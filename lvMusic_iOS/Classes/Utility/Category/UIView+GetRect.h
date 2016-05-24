//
//  UIView+GetRect.h
//  PolyCSM
//
//  Created by LV on 16/4/18.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  ScWidth   [UIScreen mainScreen].bounds.size.width
#define  ScHight   [UIScreen mainScreen].bounds.size.height

#define iPhone4_4s     (Width == 320.f && Height == 480.f ? YES : NO)
#define iPhone5_5s     (Width == 320.f && Height == 568.f ? YES : NO)
#define iPhone6_6s     (Width == 375.f && Height == 667.f ? YES : NO)
#define iPhone6_6sPlus (Width == 414.f && Height == 736.f ? YES : NO)

@interface UIView (GetRect)

//*> 绝对坐标
@property (nonatomic, assign) CGPoint lvOrigin;
@property (nonatomic, assign) CGSize  lvSize;

@property (nonatomic, assign) CGFloat lvX;
@property (nonatomic, assign) CGFloat lvY;
@property (nonatomic, assign) CGFloat lvWidth;
@property (nonatomic, assign) CGFloat lvHeight;

@property (nonatomic, assign) CGFloat lvTop;
@property (nonatomic, assign) CGFloat lvBottom;
@property (nonatomic, assign) CGFloat lvLeft;
@property (nonatomic, assign) CGFloat lvRight;

@property (nonatomic, assign) CGFloat lvCenterX;
@property (nonatomic, assign) CGFloat lvCenterY;

//*> 相对坐标
@property (nonatomic, assign, readonly) CGFloat lvMiddleHorizon;
@property (nonatomic, assign, readonly) CGFloat lvMiddleVertical;
@property (nonatomic, assign, readonly) CGPoint lvMiddlePoint;

@end
