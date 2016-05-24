//
//  AbstractViewController.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/5.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "AbstractViewController.h"

@implementation AbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Public

- (void)setup {
    self.vc_width  = [UIScreen mainScreen].bounds.size.width;
    self.vc_height = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)buildTitleView
{
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.vc_width, kAbstractNavBarHeight)];
    self.titleView.tag = kAbstractVCSubviewsTagTitleView;
    [self.view addSubview:self.titleView];
}

- (void)buildContentView
{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kAbstractNavBarHeight, self.vc_width, self.vc_height - kAbstractNavBarHeight)];
    self.contentView.tag = kAbstractVCSubviewsTagContentView;
    [self.view addSubview:self.contentView];
}

- (void)buildLoadingView
{
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, kAbstractNavBarHeight, self.vc_width, self.vc_height - kAbstractNavBarHeight)];
    self.loadingView.tag = kAbstractVCSubviewsTagLoadingView;
    [self.view addSubview:self.loadingView];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)style
{
    [[UIApplication sharedApplication] setStatusBarStyle:style];
}

@end
