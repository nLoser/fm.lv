//
//  UINavigationController+FullScreenBackGesture.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/5.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "UINavigationController+FullScreenBackGesture.h"
#import <objc/runtime.h>

static const char * associatedKeyFullScreenPanGesture       = "associated_key_fullscreenpangesture";
static const char * associatedKeyEnableFullScreenPanGesture = "associated_key_enablefullscreenpangesture";

@interface UINavigationController ()<UIGestureRecognizerDelegate>
@end

@implementation UINavigationController (FullScreenBackGesture)

#pragma mark - `enableFullScreenPanGesture` Getter/Setter Action

- (void)setEnableFullScreenPanGesture:(BOOL)enableFullScreenPanGesture
{
    objc_setAssociatedObject(self, associatedKeyEnableFullScreenPanGesture, [NSNumber numberWithBool:enableFullScreenPanGesture], OBJC_ASSOCIATION_ASSIGN);
    UIPanGestureRecognizer * fullScreenPan = [self createFullScreenPanGesture];
    if (enableFullScreenPanGesture) {
        [self.view addGestureRecognizer:fullScreenPan];
    }else {
        [self.view removeGestureRecognizer:fullScreenPan];
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)enableFullScreenPanGesture
{
    return [(NSNumber *)objc_getAssociatedObject(self, associatedKeyEnableFullScreenPanGesture) boolValue];
}

#pragma mark - 获取系统pop方法，创建一个pan的手势

- (UIPanGestureRecognizer *)createFullScreenPanGesture
{
    UIPanGestureRecognizer * fullScrrenPan = objc_getAssociatedObject(self, associatedKeyFullScreenPanGesture);
    if (!fullScrrenPan) {
        id interactiveTarget = self.interactivePopGestureRecognizer.delegate;
        fullScrrenPan = [[UIPanGestureRecognizer alloc] initWithTarget:interactiveTarget action:@selector(handleNavigationTransition:)];
        fullScrrenPan.delegate = self;
        objc_setAssociatedObject(self, associatedKeyFullScreenPanGesture, fullScrrenPan, OBJC_ASSOCIATION_RETAIN);
    }
    return fullScrrenPan;
}

#pragma mark - UIGestureRecognizeDelegate Action

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

@end
