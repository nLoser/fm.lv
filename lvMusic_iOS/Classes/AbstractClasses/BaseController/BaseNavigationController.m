//
//  BaseNavigationController.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/5.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationController+FullScreenBackGesture.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.enableFullScreenPanGesture = YES;
    self.navigationBarHidden        = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
