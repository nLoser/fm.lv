//
//  AbstractViewController.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/5.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "UIFont+GetFont.h"
#import "UIView+GetRect.h"
#import "AbstractViewControllerSubviewsTagValue.h"

#define kAbstractNavBarHeight 64.f
#define kAbstractTabBarHeight 44.f

@interface AbstractViewController : UIViewController

@property (nonatomic, assign) CGFloat vc_width;
@property (nonatomic, assign) CGFloat vc_height;

//*> 优先级中 vc_width * 64.f
@property (nonatomic, strong) UIView * titleView;
//*> 优先级中 vc_width * (vc_height - 64.f)
@property (nonatomic, strong) UIView * contentView;
//*> 优先级高 vc_width * (vc_heigth - 64.f)
@property (nonatomic, strong) UIView * loadingView;


/* !基础设置 */
- (void)setup;

- (void)buildTitleView;
- (void)buildContentView;
- (void)buildLoadingView;

- (void)setStatusBarStyle:(UIStatusBarStyle)style;

@end
