//
//  CMAudioPlayer.h
//  lvMusic_iOS
//
//  Created by LV on 16/6/2.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioFile.h>

typedef NS_ENUM(NSUInteger, CMAStatus)
{
    CMAStatusStopped = 0, //停止
    CMAStatusPlaying = 1, //播放
    CMAStatusWaiting = 2, //下载资源
    CMAStatusPause   = 3, //暂停
    CMAStatusresume  = 4  //重启
};
@interface CMAudioPlayer : NSObject
@property (nonatomic, copy, readonly) NSString * filePath;
@property (nonatomic, assign, readonly) AudioFileTypeID fileType;

@property (nonatomic, readonly) CMAStatus status;
@property (nonatomic, readonly) BOOL isPlayingOrWaiting;
@property (nonatomic, readonly) BOOL failed;

@property (nonatomic, assign) NSTimeInterval progress;
@property (nonatomic, readonly) NSTimeInterval * duration;

- (instancetype)initWithFilePath:(NSString *)filePath fileType:(AudioFileTypeID)fileType;

- (void)play;
- (void)pause;
- (void)stop;
@end
