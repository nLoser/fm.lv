//
//  ViewController.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/5.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "ViewController.h"
#import "CoreMusicPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MPBottomToolItem * item = [MPBottomToolItem new];
    item.imgName = @"dsadsa";
    item.tag = 1;
    item.up_frame = CGRectZero;
    item.dn_frame = CGRectZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
