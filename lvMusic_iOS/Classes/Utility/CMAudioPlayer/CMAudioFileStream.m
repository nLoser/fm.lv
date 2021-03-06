//
//  CMAudioFileStream.m
//  lvMusic_iOS
//
//  Created by LV on 16/6/2.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "CMAudioFileStream.h"

#define BitRateEstimationMaxPackets 5000
#define BitRateEstimationMinPackets 10

@interface CMAudioFileStream ()
{
@private
    BOOL _discontinuous;
    AudioFileStreamID _audioFileStreamID;
    
    SInt64 _dataOffset;
    NSTimeInterval _packetDuration;
    
    UInt64 _processPacketsCount;
    UInt64 _processPacketsSizeTotal;
}
#pragma mark - CallBack
- (void)handleAudioFileStreamProperty:(AudioFileStreamPropertyID)propetyID;
- (void)handleAudioFileStreamPackets:(const void *)packets
                       numberOfBytes:(UInt32)numberOfBytes
                     numberOfPackets:(UInt32)numberOfPackets
                  packetDescriptions:(AudioStreamPacketDescription *)packetDescription;
@end

#pragma mark - static callbacks
static void CMAudioFileStreamPropertyListener(void *inClinet,
                                              AudioFileStreamID inAudioFileStream,
                                              AudioFileStreamPropertyID inPropertyID,
                                              UInt32 *ioFlags)
{
    CMAudioFileStream * audioFileStream = (__bridge CMAudioFileStream*)inClinet;
    [audioFileStream handleAudioFileStreamProperty:inPropertyID];
}

static void CMAudioFileStreamPacketsCallBack(void *inClinet,
                                             UInt32 inNumberBytes,
                                             UInt32 inNumberPackets,
                                             const void * inInputData,
                                             AudioStreamPacketDescription *inPacketDescription)
{
    CMAudioFileStream * audioFileStream = (__bridge CMAudioFileStream *)inClinet;
    [audioFileStream handleAudioFileStreamPackets:inInputData
                                    numberOfBytes:inNumberBytes
                                  numberOfPackets:inNumberPackets
                               packetDescriptions:inPacketDescription];
}

#pragma mark -
@implementation CMAudioFileStream
@synthesize fileType = _fileType;
@synthesize readyToProducePackets = _readyToProducePackets;
@synthesize delegate = _delegate;
@synthesize duration = _duration;
@synthesize bitRate = _bitRate;
@synthesize format = _format;
@synthesize maxPacketSize = _maxPacketSize;
@synthesize audioDataByteCount = _audioDataByteCount;
@dynamic available; // 编译器并不会直接生成getter/setter 而是手工生成或者运行时生成

#pragma mark init & dealloc

- (instancetype)initWithFileType:(AudioFileTypeID)fileType fileSize:(unsigned long long)fileSize error:(NSError *__autoreleasing *)error
{
    self = [super init];
    if (self) {
        _discontinuous = NO;
        _fileType = fileType;
        _fileSize = fileSize;
        [self _openAudioFileStreamWithFileTypeHint:_fileType error:error];
    }
    return self;
}

- (void)dealloc
{
    [self _closeAudioFileStream];
}

#pragma mark - Private

- (BOOL)_openAudioFileStreamWithFileTypeHint:(AudioFileTypeID)fileTypeHint error:(NSError **)error
{
    OSStatus status = AudioFileStreamOpen((__bridge void * _Nullable)(self),
                                          CMAudioFileStreamPropertyListener,
                                          CMAudioFileStreamPacketsCallBack,
                                          fileTypeHint,
                                          &_audioFileStreamID);
    if (status != noErr) {
        _audioFileStreamID = NULL;
    }
    [self _errorForOSStatus:status error:error];
    return status == noErr;
}

- (void)_errorForOSStatus:(OSStatus)status error:(NSError **)outErr
{
    if (status != noErr && outErr != NULL) {
        * outErr = [NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:nil];
    }
}

- (void)_closeAudioFileStream
{
    if (self.available) {
        AudioFileStreamClose(_audioFileStreamID);
        _audioFileStreamID = NULL;
    }
}

- (BOOL)available
{
    return _audioFileStreamID != NULL;
}

#pragma mark - Public 

- (void)close
{
    [self _closeAudioFileStream];
}

- (NSData *)fetchMagicCookie
{
    UInt32 cookieSize;
    Boolean writeable;
    OSStatus status = AudioFileStreamGetProperty(_audioFileStreamID, kAudioFileStreamProperty_MagicCookieData, &cookieSize, &writeable);
    if (status != noErr) {
        return nil;
    }
    
    void * cookieData = malloc(cookieSize);
    status = AudioFileStreamGetProperty(_audioFileStreamID,
                                        kAudioFileStreamProperty_MagicCookieData, &cookieSize, cookieData);
    NSData * cookie = [NSData dataWithBytes:cookieData length:cookieSize];
    free(cookieData);
    
    return cookie;
}

- (BOOL)parseData:(NSData *)data error:(NSError *__autoreleasing *)error
{
    if (self.readyToProducePackets && _packetDuration == 0) {
        [self _errorForOSStatus:-1 error:error];
        return NO;
    }
    
    OSStatus status = AudioFileStreamParseBytes(_audioFileStreamID,
                                                (UInt32)[data length],
                                                [data bytes],
                                                _discontinuous ? kAudioFileStreamParseFlag_Discontinuity:0);
    [self _errorForOSStatus:status error:error];
    return status == noErr;
}

- (SInt64)seekToTime:(NSTimeInterval *)time
{
    SInt64 approximateSeekOffset = _dataOffset + (*time/_duration) * _audioDataByteCount;
    SInt64 seekToPacket = floor(*time/_packetDuration);
    
    SInt64 seekByteOffset;
    UInt32 ioFlags = 0;
    SInt64 outDataByteOffset;
    
    OSStatus status = AudioFileStreamSeek(_audioFileStreamID, seekToPacket, &outDataByteOffset, &ioFlags);
    if (status == noErr && !(ioFlags & kAudioFileStreamSeekFlag_OffsetIsEstimated)) {
        *time -= ((approximateSeekOffset - _dataOffset) - outDataByteOffset) * 8.0 / _bitRate;
        seekByteOffset = outDataByteOffset + _dataOffset;
    }else {
        _discontinuous = YES;
        seekByteOffset = approximateSeekOffset;
    }
    return seekByteOffset;
}

#pragma mark - Call Backs 

- (void)calculateBitRate
{
    if (_packetDuration && _processPacketsCount > BitRateEstimationMinPackets && _processPacketsCount <= BitRateEstimationMaxPackets)
    {
        double averagePacketByteSize = _processPacketsCount / _processPacketsCount;
        _bitRate = 8.0 * averagePacketByteSize / _packetDuration;
    }
}

- (void)calculateDuration
{
    if (_fileSize > 0 && _bitRate > 0)
    {
        _duration = ((_fileSize - _dataOffset) * 8.0) / _bitRate;
    }
}

- (void)calculatepPacketDuration
{
    if (_format.mSampleRate > 0)
    {
        _packetDuration = _format.mFramesPerPacket / _format.mSampleRate;
    }
}

/********************************************/

- (void)handleAudioFileStreamProperty:(AudioFileStreamPropertyID)propetyID
{
    if (propetyID == kAudioFileStreamProperty_ReadyToProducePackets)
    {
        UInt32 sizeOfUInt32 = sizeof(_maxPacketSize);
        OSStatus status = AudioFileStreamGetProperty(_audioFileStreamID, kAudioFileStreamProperty_PacketSizeUpperBound, &sizeOfUInt32, &_maxPacketSize);
        if (status != noErr || _maxPacketSize == 0)
        {
            status = AudioFileStreamGetProperty(_audioFileStreamID, kAudioFileStreamProperty_MaximumPacketSize, &sizeOfUInt32, &_maxPacketSize);
        }
        if (_delegate && [_delegate respondsToSelector:@selector(audioFileStreamReadyToProducePackets:)])
        {
            [_delegate audioFileStreamReadyToProducePackets:self];
        }
    }
    else if (propetyID == kAudioFileStreamProperty_DataOffset)
    {
        UInt32 offsetSize = sizeof(_dataOffset);
        AudioFileStreamGetProperty(_audioFileStreamID, kAudioFileStreamProperty_DataOffset, &offsetSize, &_dataOffset);
        _audioDataByteCount = _fileSize - _dataOffset;
        [self calculateDuration];
    }
    else if (propetyID == kAudioFileStreamProperty_DataFormat)
    {
        UInt32 asbdSize = sizeof(_format);
        AudioFileStreamGetProperty(_audioFileStreamID, kAudioFileStreamProperty_DataFormat, &asbdSize, &_format);
        [self calculatepPacketDuration];
    }
    else if (propetyID == kAudioFileStreamProperty_FormatList)
    {
        Boolean outWriteable;
        UInt32 formatListSize;
        OSStatus status = AudioFileStreamGetPropertyInfo(_audioFileStreamID, kAudioFileStreamProperty_FormatList, &formatListSize, &outWriteable);
        if (status == noErr)
        {
            AudioFormatListItem *formatList = malloc(formatListSize);
            OSStatus status = AudioFileStreamGetProperty(_audioFileStreamID, kAudioFileStreamProperty_FormatList, &formatListSize, formatList);
            if (status == noErr)
            {
                UInt32 supportedFormatsSize;
                status = AudioFormatGetPropertyInfo(kAudioFormatProperty_DecodeFormatIDs, 0, NULL, &supportedFormatsSize);
                if (status != noErr)
                {
                    free(formatList);
                    return;
                }
                
                UInt32 supportedFormatCount = supportedFormatsSize / sizeof(OSType);
                OSType *supportedFormats = (OSType *)malloc(supportedFormatsSize);
                status = AudioFormatGetProperty(kAudioFormatProperty_DecodeFormatIDs, 0, NULL, &supportedFormatsSize, supportedFormats);
                if (status != noErr)
                {
                    free(formatList);
                    free(supportedFormats);
                    return;
                }
                
                for (int i = 0; i * sizeof(AudioFormatListItem) < formatListSize; i += sizeof(AudioFormatListItem))
                {
                    AudioStreamBasicDescription format = formatList[i].mASBD;
                    for (UInt32 j = 0; j < supportedFormatCount; ++j)
                    {
                        if (format.mFormatID == supportedFormats[j])
                        {
                            _format = format;
                            [self calculatepPacketDuration];
                            break;
                        }
                    }
                }
                free(supportedFormats);
            }
            free(formatList);
        }
    }
}

- (void)handleAudioFileStreamPackets:(const void *)packets
                       numberOfBytes:(UInt32)numberOfBytes
                     numberOfPackets:(UInt32)numberOfPackets
                  packetDescriptions:(AudioStreamPacketDescription *)packetDescriptioins
{
    if (_discontinuous)
    {
        _discontinuous = NO;
    }
    
    if (numberOfBytes == 0 || numberOfPackets == 0)
    {
        return;
    }
    
    BOOL deletePackDesc = NO;
    if (packetDescriptioins == NULL)
    {
        deletePackDesc = YES;
        UInt32 packetSize = numberOfBytes / numberOfPackets;
        AudioStreamPacketDescription *descriptions = (AudioStreamPacketDescription *)malloc(sizeof(AudioStreamPacketDescription) * numberOfPackets);
        
        for (int i = 0; i < numberOfPackets; i++)
        {
            UInt32 packetOffset = packetSize * i;
            descriptions[i].mStartOffset = packetOffset;
            descriptions[i].mVariableFramesInPacket = 0;
            if (i == numberOfPackets - 1)
            {
                descriptions[i].mDataByteSize = numberOfBytes - packetOffset;
            }
            else
            {
                descriptions[i].mDataByteSize = packetSize;
            }
        }
        packetDescriptioins = descriptions;
    }
    
    NSMutableArray *parsedDataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < numberOfPackets; ++i)
    {
        SInt64 packetOffset = packetDescriptioins[i].mStartOffset;
        CMParsedAudioData *parsedData = [CMParsedAudioData parsedAudioDataWithBytes:packets + packetOffset
                                                                  packetDescription:packetDescriptioins[i]];
        
        [parsedDataArray addObject:parsedData];
        
        if (_processPacketsCount < BitRateEstimationMaxPackets)
        {
            _processPacketsSizeTotal += parsedData.packetDescription.mDataByteSize;
            _processPacketsCount += 1;
            [self calculateBitRate];
            [self calculateDuration];
        }
    }
    
    [_delegate audioFileStream:self audioDataParsed:parsedDataArray];
    
    if (deletePackDesc)
    {
        free(packetDescriptioins);
    }
}


@end
