//
//  BaseNormalViewController.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/6.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "BaseNormalViewController.h"

@interface BaseNormalViewController ()

@end

@implementation BaseNormalViewController
@synthesize enablePush = _enablePush;

- (void)setup
{
    [super setup];
    [self buildTitleView];
    [self buildContentView];
    [self buildLoadingView];
}

- (void)buildTitleView
{
    [super buildTitleView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
