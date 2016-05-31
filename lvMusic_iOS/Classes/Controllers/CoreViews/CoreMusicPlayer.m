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

@property (nonatomic, strong) UITapGestureRecognizer * clickTap;  // tap
@property (nonatomic, strong) UIPanGestureRecognizer * slidePan;  // silde

@property (nonatomic, assign) CGRect firstRect;
@property (nonatomic, assign) CGFloat startPanY;
@property (nonatomic, assign) CGFloat EndPanY;
@property (nonatomic, assign) CGFloat compressRate;   //*> supview压缩比例
@property (nonatomic, assign) CGFloat compressDiffer; //*> supview压缩尺码
@property (nonatomic, assign) CGFloat bottomCurrentHeight;
@end

@implementation CoreMusicPlayer
@synthesize boundState;   // 播放界面状态：展开／压缩
@synthesize playerView,musicProgress,bottomToolView;
@synthesize clickTap,slidePan;
@synthesize firstRect,startPanY,EndPanY,compressRate,compressDiffer,bottomCurrentHeight;

#pragma mark -
#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    boundState = CoreMusicPlayerBoundStatusExpanded;
    firstRect  = CGRectMake(0, 0, ScWidth, ScHight);
    startPanY = EndPanY = 0;
    compressRate   = 1;
    compressDiffer = 0;
    bottomCurrentHeight = kBottomMax_H;
    
    [self makeDefaultUserInterface];
    [self addGestureRecognizers];
    
    return self;
}

- (void)addGestureRecognizers
{
    clickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTapAction:)];
    [self addGestureRecognizer:clickTap];
    
    slidePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(silidePanAction:)];
    slidePan.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:slidePan];
}

- (void)makeDefaultUserInterface
{
    self.frame = firstRect;
    self.backgroundColor = [UIColor yellowColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    playerView = [CMPlayer new];
    playerView.backgroundColor = [UIColor grayColor];
    [self addSubview:playerView];
    
    bottomToolView = [CMToolView new];
    bottomToolView.backgroundColor = [UIColor orangeColor];
    [self addSubview:bottomToolView];
    
    [playerView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [bottomToolView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(bottomCurrentHeight);
    }];
}

#pragma mark -
#pragma mark - Gesture & Stretch Action

- (void)silidePanAction:(UIPanGestureRecognizer *)recognizer
{
    CGFloat first_H = firstRect.size.height;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        startPanY = [recognizer locationInView:self].y;
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        EndPanY = [recognizer locationInView:self].y;
        CGFloat differ      = EndPanY - startPanY;
        CGFloat flagHeight  = self.lvHeight - differ;
        CGFloat flagGapping = 10.f;
        
        //*> 'self.frame.size.height' must be less than 'first_H'
        if (flagHeight >= first_H) return;
        
        if (flagHeight > first_H - flagGapping) {
            //*> Auto large
            [self stretchContent:self.lvHeight - first_H animated:NO];
        } else if (flagHeight < kBottomMin_H + flagGapping) {
            //*> Auto shrink
            [self stretchContent:self.lvHeight - kBottomMin_H animated:NO];
        } else if (flagHeight > kBottomMin_H) {
            //*> Normal compress
            [self stretchContent:differ animated:NO];
        }
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        startPanY = EndPanY = 0;
        if (self.lvHeight > first_H * 0.5) {
            [self stretchContent:self.lvHeight - first_H animated:YES];
            boundState = CoreMusicPlayerBoundStatusExpanded;
        }else {
            [self stretchContent:self.lvHeight - kBottomMin_H animated:YES];
            boundState = CoreMusicPlayerBoundStatusShrinking;
        }
    }
}

- (void)clickTapAction:(UITapGestureRecognizer *)recognizer
{
    if (boundState == CoreMusicPlayerBoundStatusExpanded) return;
    [self stretchContent:self.lvHeight - firstRect.size.height animated:YES];
}

- (void)stretchContent:(CGFloat)differ animated:(BOOL)animated
{
    compressDiffer = differ;
    compressRate   = (self.lvHeight-differ-kBottomMin_H)/(firstRect.size.height - kBottomMin_H);
    bottomCurrentHeight = kBottomMax_H - (kBottomMax_H-kBottomMin_H)*(1-compressRate);
    
    [bottomToolView compress:bottomCurrentHeight];
    
    //*> Reset Constraints -> Change Layout
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    if (!animated) return;
    [UIView animateWithDuration:kDefaultCompressDuration animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark -
#pragma mark - AutoLayout

- (void)updateConstraints
{
    UIView * selfView = self;
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfView.lvTop + compressDiffer);
        make.height.equalTo(selfView.lvHeight - compressDiffer);
    }];
    [super updateConstraints];
}

- (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
