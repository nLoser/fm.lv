//
//  CMPlayerManager.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/31.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "CMPlayerManager.h"

static CMPlayerManager * playerManager = nil;

@implementation CMPlayerManager

#pragma mark -
#pragma mark - Initialize Singleton project
+ (instancetype)shareInstance {
    if (self != [CMPlayerManager class]) {
        [NSException raise:@"CMPlayerManager" format:@"Cannot use shareManager method form subClass"];
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerManager = [[CMPlayerManager alloc] initIntance];
    });
    return playerManager;
}

- (instancetype)init {
    [NSException raise:@"CMPlayerManager" format:@"Cannot instance singleton using 'init' method, must be used 'shareInstance'"];
    return nil;
}
- (id)initIntance {
    self.songList = [NSMutableArray array];
    return [super init];
}

#pragma mark -
#pragma mark - 列表

- (UIImage *)currentSongCoverImg
{
    if (_currentSongCoverImg == nil) {
        return [UIImage imageNamed:@"musicCover"];
    }
    return _currentSongCoverImg;
}

#pragma mark - 
#pragma mark - 播放器

- (BOOL)isPlayer
{
    return self.player.rate == 1.0;
}

- (void)setPlayDuration:(NSString *)playDuration
{
    if (![_playDuration isEqualToString:playDuration] &&
        ![_playDuration isEqualToString:@"0"]) {
        _playDuration = playDuration;
        
    }
}

@end
