//
//  CMPlayerManager.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/31.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CoreMusicState.h"
#import "CMSongInfo.h"

@interface CMPlayerManager : NSObject{
    id _timeObserve; // 监控进度
}

@property (nonatomic, assign) CoreMusicPlayerPlayStatus playStatus;

#pragma mark - 频道

#pragma mark - 列表
@property (nonatomic, strong) NSMutableArray<CMSongInfo*> *songList;
@property (nonatomic, strong) CMSongInfo * currentSong;
@property (nonatomic, assign) NSInteger  currentSongIndex;//当前播放歌曲索引
@property (nonatomic, strong) UIImage    * currentSongCoverImg;

#pragma mark - 播放器
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, assign) BOOL     isPlaying;
@property (nonatomic, assign) CGFloat  progress;
@property (nonatomic, assign) CGFloat  bufProgress;

@property (nonatomic, strong) NSString * playTime; // 当前播放时间(秒)
@property (nonatomic, strong) NSString * TimeNow;  //当前播放时间(00:00)
@property (nonatomic, strong) NSString * playDuration;//总长

#pragma mark - Method
+ (instancetype)shareInstance;
- (void)startPlay;
- (void)pausePlay;

- (void)skipSongWithHandle:(void(^)(BOOL isSucc))handle;
- (void)banSongWithHandle:(void(^)(BOOL isSucc))handle;

@property (nonatomic, assign) BOOL isOffLinePlay; // 是否播放离线音乐
- (void)playOffLineList:(NSArray*)songList index:(NSUInteger)index;

@end
