//
//  CMAudioFileStream.h
//  lvMusic_iOS
//
//  Created by LV on 16/6/2.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CMParsedAudioData.h"

@class CMAudioFileStream;
@protocol CMAudioFileStreamDelegate <NSObject>

@required
- (void)audioFileStream:(CMAudioFileStream *)audioFileStream audioDataParsed:(NSArray *)audioData;
@optional
- (void)audioFileStreamReadyToProducePackets:(CMAudioFileStream *)audioFileStream;
@end

@interface CMAudioFileStream : NSObject

@property (nonatomic, readonly) AudioFileTypeID fileType;
@property (nonatomic, readonly) BOOL available;
@property (nonatomic, readonly) BOOL readyToProducePackets;
@property (nonatomic, weak) id<CMAudioFileStreamDelegate>delegate;

@property (nonatomic, readonly) AudioStreamBasicDescription format;
@property (nonatomic, readonly) unsigned long long fileSize;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) UInt32 bitRate;
@property (nonatomic, readonly) UInt32 maxPacketSize;
@property (nonatomic, readonly) UInt64 audioDataByteCount;

#pragma mark - Public
- (instancetype)initWithFileType:(AudioFileTypeID)fileType
                        fileSize:(unsigned long long)fileSize
                           error:(NSError **)error;

- (BOOL)parseData:(NSData *)data error:(NSError **)error;

- (SInt64)seekToTime:(NSTimeInterval *)time;/*! seek byte offset */

- (NSData *)fetchMagicCookie;

- (void)close;

@end
