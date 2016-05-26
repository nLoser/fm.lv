//
//  CoreMusicPlayer.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/26.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "CoreMusicPlayer.h"
#import "CMPlayer.h"
#import "CMToolView.h"

@interface CoreMusicPlayer ()
@property (nonatomic, strong) CMPlayer * playerView;
@property (nonatomic, strong) CMToolView * bottomToolView;
@property (nonatomic, strong) UIProgressView * musicProgress;
@end

@implementation CoreMusicPlayer
@synthesize playerView,musicProgress,bottomToolView;

#pragma mark - Life Cycle

- (void)createPlayerView
{
    playerView = [[CMPlayer alloc] initWithFrame:self.bounds];
}

- (void)createBottomToolView
{
    
}

- (void)configUI
{
    [self createPlayerView];
    [self createBottomToolView];
}

- (instancetype)initWithSth
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

@end
