//
//  CMParsedAudioData.h
//  lvMusic_iOS
//
//  Created by LV on 16/6/2.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface CMParsedAudioData : NSObject
@property (nonatomic, readonly) NSData * data;
@property (nonatomic, readonly) AudioStreamPacketDescription packetDescription;

+ (instancetype)parsedAudioDataWithBytes:(const void *)bytes
                       packetDescription:(AudioStreamPacketDescription)packetDescription;
@end
