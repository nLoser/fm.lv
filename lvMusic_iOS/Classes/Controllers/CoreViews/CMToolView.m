//
//  CMToolView.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/26.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "CMToolView.h"

#define kCM_PLAYBTN_SIZE        CGSizeMake(66, 66)
#define kCM_NORMALBTN_SIZE      CGSizeMake(49, 49)
#define kCM_PLAYDEFAULT_CENTER  CGPointZero

#define kCM_BTNS_GAPPING 12.f
#define kCM_SELF_HEIGHT 110.f


@interface CMToolView ()
@property (nonatomic, strong) UIButton * cmt_playBtn;
@property (nonatomic, strong) UIButton * cmt_prevBtn;
@property (nonatomic, strong) UIButton * cmt_nextBtn;

@property (nonatomic, assign) CGSize  playBtnSize;
@property (nonatomic, assign) CGPoint playCenter;
@property (nonatomic, assign) CGSize  otherBtnSize;
@property (nonatomic, assign) CGFloat gapping;
@property (nonatomic, assign) CGFloat selfHeight;
@end

@implementation CMToolView
@synthesize cmt_playBtn,cmt_prevBtn,cmt_nextBtn;
@synthesize playBtnSize,playCenter,otherBtnSize,gapping,selfHeight;

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    [self makeDefaultUserInterface];
    [self makeToolBtnAction];
    return self;
}

- (void)makeDefaultUserInterface
{
    playBtnSize  = kCM_PLAYBTN_SIZE;
    otherBtnSize = kCM_NORMALBTN_SIZE;
    playCenter   = kCM_PLAYDEFAULT_CENTER;
    gapping      = kCM_BTNS_GAPPING;
    selfHeight   = kCM_SELF_HEIGHT;
    
    cmt_playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cmt_playBtn setImage:[UIImage imageNamed:@"ic_action_play"] forState:UIControlStateNormal];
    cmt_playBtn.layer.borderColor = [UIColor blueColor].CGColor;
    cmt_playBtn.layer.borderWidth = 1.f;
    cmt_playBtn.layer.cornerRadius   = playBtnSize.width/2.f;
    cmt_playBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cmt_playBtn.layer.shouldRasterize = YES;
    cmt_playBtn.layer.masksToBounds = YES;
    [cmt_playBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
    [self addSubview:cmt_playBtn];
    
    cmt_prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cmt_prevBtn setImage:[UIImage imageNamed:@"ic_action_prev"] forState:UIControlStateNormal];
    [cmt_prevBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self addSubview:cmt_prevBtn];
    
    cmt_nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cmt_nextBtn setImage:[UIImage imageNamed:@"ic_action_next"] forState:UIControlStateNormal];
    [cmt_nextBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self addSubview:cmt_nextBtn];
}

- (void)makeToolBtnAction
{
    [cmt_playBtn addTarget:self action:@selector(playBtnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUpView)]];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended place for adding/updating constraints.
- (void)updateConstraints
{
    [cmt_playBtn updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(playBtnSize);
        make.center.equalTo(playCenter);
    }];
    
    [cmt_prevBtn updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(otherBtnSize);
        make.centerY.equalTo(playCenter.y);
        make.right.equalTo(cmt_playBtn.left).offset(-gapping);
    }];
    [cmt_nextBtn updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(otherBtnSize);
        make.centerY.equalTo(playCenter.y);
        make.left.equalTo(cmt_playBtn.right).offset(gapping);
    }];
    
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(selfHeight);
    }];
    
    // according to apple super should be called at end of method.
    [super updateConstraints];
}

#pragma mark - Target Action

- (void)playBtnAction1:(UIButton *)button
{
    playCenter  = CGPointMake(70, 0);
    playBtnSize = kCM_NORMALBTN_SIZE;
    selfHeight  = (kCM_SELF_HEIGHT - 51);
    gapping     = kCM_BTNS_GAPPING/2.f;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        cmt_playBtn.layer.borderWidth  = 0.f;
        cmt_prevBtn.alpha = 0;
        [self layoutIfNeeded];
    }];
}

- (void)tapUpView
{
    playCenter  = kCM_PLAYDEFAULT_CENTER;
    playBtnSize = kCM_PLAYBTN_SIZE;
    selfHeight  = kCM_SELF_HEIGHT;
    gapping     = kCM_BTNS_GAPPING;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        cmt_playBtn.layer.borderWidth  = 1.f;
        cmt_prevBtn.alpha = 1;
        [self layoutIfNeeded];
    }];
}

@end
