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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self makeDefaultUserInterface];
    return self;
}

- (void)makeDefaultUserInterface
{
    self.backgroundColor = [UIColor yellowColor];
    
    playerView = [CMPlayer new];
    playerView.backgroundColor = [UIColor grayColor];
    [self addSubview:playerView];
    
    bottomToolView = [CMToolView new];
    bottomToolView.backgroundColor = [UIColor orangeColor];
    [self addSubview:bottomToolView];
    
    UIView * superView = self;
    int padding = 20;
    
    [playerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.top).offset(padding);
        make.left.equalTo(superView.left).offset(0);
        make.bottom.equalTo(bottomToolView.top).offset(-2);
        make.right.equalTo(superView.right).offset(0);
    }];
    
    [bottomToolView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playerView.bottom).offset(2);
        make.left.equalTo(superView.left).offset(0);
        make.bottom.equalTo(superView.bottom).offset(-2);
        make.right.equalTo(superView.right).offset(0);
        
        make.height.equalTo(110);
    }];
    
}

@end
