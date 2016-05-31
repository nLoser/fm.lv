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
    
    CoreMusicPlayer * player = [CoreMusicPlayer new];
    [self.view addSubview:player];

    [player makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
