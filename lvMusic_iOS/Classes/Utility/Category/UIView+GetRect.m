//
//  UIView+GetRect.m
//  PolyCSM
//
//  Created by LV on 16/4/18.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "UIView+GetRect.h"

@implementation UIView (GetRect)

- (CGPoint)lvOrigin
{
    return self.frame.origin;
}

- (void)setLvOrigin:(CGPoint)lvOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin = lvOrigin;
    self.frame      = newFrame;
}

- (CGSize)lvSize
{
    return self.frame.size;
}

- (void)setLvSize:(CGSize)lvSize
{
    CGRect newFrame = self.frame;
    newFrame.size   = lvSize;
    self.frame      = newFrame;
}

- (CGFloat)lvX
{
    return self.frame.origin.x;
}

- (void)setLvX:(CGFloat)lvX
{
    CGRect newFrame   = self.frame;
    newFrame.origin.x = lvX;
    self.frame        = newFrame;
}

- (CGFloat)lvY
{
    return self.frame.origin.y;
}

- (void)setLvY:(CGFloat)lvY
{
    CGRect newFrame   = self.frame;
    newFrame.origin.y = lvY;
    self.frame        = newFrame;
}

- (CGFloat)lvWidth
{
    return self.frame.size.width;
}

- (void)setLvWidth:(CGFloat)lvWidth
{
    CGRect newFrame     = self.frame;
    newFrame.size.width = lvWidth;
    self.frame          = newFrame;
}

- (CGFloat)lvHeight
{
    return self.frame.size.height;
}

- (void)setLvHeight:(CGFloat)lvHeight
{
    CGRect newFrame      = self.frame;
    newFrame.size.height = lvHeight;
    self.frame           = newFrame;
}

- (CGFloat)lvTop
{
    return self.frame.origin.y;
}

- (void)setLvTop:(CGFloat)lvTop
{
    CGRect newFrame   = self.frame;
    newFrame.origin.y = lvTop;
    self.frame        = newFrame;
}

- (CGFloat)lvBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLvBottom:(CGFloat)lvBottom
{
    CGRect newFrame   = self.frame;
    newFrame.origin.y = lvBottom - self.frame.size.height;
    self.frame        = newFrame;
}

- (CGFloat)lvLeft
{
    return self.frame.origin.x;
}

- (void)setLvLeft:(CGFloat)lvLeft
{
    CGRect newFrame   = self.frame;
    newFrame.origin.x = lvLeft;
    self.frame        = newFrame;
}

- (CGFloat)lvRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLvRight:(CGFloat)lvRight
{
    CGRect newFrame   = self.frame;
    newFrame.origin.x = lvRight - self.frame.size.width;
    self.frame        = newFrame;
}

- (CGFloat)lvCenterX
{
    return self.center.x;
}

- (void)setLvCenterX:(CGFloat)lvCenterX
{
    CGPoint newCenter = self.center;
    newCenter.x = lvCenterX;
    self.center = newCenter;
}


- (CGFloat)lvCenterY
{
    return self.center.y;
}

- (void)setLvCenterY:(CGFloat)lvCenterY
{
    CGPoint newCenter = self.center;
    newCenter.y = lvCenterY;
    self.center = newCenter;
}

/**
 相对坐标
 @property (nonatomic, assign, readonly) CGFloat lvMiddleX;
 @property (nonatomic, assign, readonly) CGFloat lvMiddleY;
 @property (nonatomic, assign, readonly) CGPoint lvMiddlePoint;
 */

- (CGFloat)lvMiddleHorizon
{
    return CGRectGetWidth(self.bounds)/2.f;
}

- (CGFloat)lvMiddleVertical
{
    return CGRectGetHeight(self.bounds)/2.f;
}

- (CGPoint)lvMiddlePoint
{
    return CGPointMake(CGRectGetWidth(self.bounds)/2.f, CGRectGetHeight(self.bounds)/2.f);
}

@end
