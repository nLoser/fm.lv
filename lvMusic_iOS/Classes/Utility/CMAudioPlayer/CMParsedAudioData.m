//
//  CMParsedAudioData.m
//  lvMusic_iOS
//
//  Created by LV on 16/6/2.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "CMParsedAudioData.h"

@implementation CMParsedAudioData
@synthesize data = _data;
@synthesize packetDescription = _packetDescription;

+ (instancetype)parsedAudioDataWithBytes:(const void *)bytes
                       packetDescription:(AudioStreamPacketDescription)packetDescription
{
    return [[self alloc] initWithBytes:bytes packetDescription:packetDescription];
}

- (instancetype)initWithBytes:(const void *)bytes packetDescription:(AudioStreamPacketDescription)packetDescription
{
    if (bytes == NULL || packetDescription.mDataByteSize == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _data = [NSData dataWithBytes:bytes length:packetDescription.mDataByteSize];
        _packetDescription = packetDescription;
    }
    return self;
}

@end
