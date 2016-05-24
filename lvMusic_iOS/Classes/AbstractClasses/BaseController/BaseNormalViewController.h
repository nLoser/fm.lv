//
//  BaseNormalViewController.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/6.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "AbstractViewController.h"

@interface BaseNormalViewController : AbstractViewController

@property (nonatomic, assign) BOOL enablePush;
@property (nonatomic, strong) UIBarButtonItem * navLeftBtn;
@property (nonatomic, strong) UIBarButtonItem * navRightBtn;

@end
