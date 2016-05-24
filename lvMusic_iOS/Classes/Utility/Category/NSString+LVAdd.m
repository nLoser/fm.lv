//
//  NSString+LVAdd.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/23.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "NSString+LVAdd.h"

@implementation NSString (LVAdd)

+ (NSString *)stringWithUUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge NSString *)(string);
}

@end
