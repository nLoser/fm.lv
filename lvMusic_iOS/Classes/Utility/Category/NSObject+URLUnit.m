//
//  NSObject+URLUnit.m
//  lvMusic_iOS
//
//  Created by LV on 16/6/15.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "NSObject+URLUnit.h"

@implementation NSObject (URLUnit)

- (void)console_URLINFO:(NSURL *)url
{
    printf("\n\n-------- 😊%s --------\n\n",url.absoluteString.UTF8String);
    printf("😄 scheme - %s\n",[url scheme].UTF8String);
    printf("😄 host - %s\n",[url host].UTF8String);
    printf("😄 port - %d\n",[[url port] intValue]);
    printf("😄 path - %s\n",[url path].UTF8String);
    printf("😄 relativePath - %s\n",[url relativePath].UTF8String);
    printf("😄 pathComponents - %s\n",[NSString stringWithFormat:@"%@",[url pathComponents]].UTF8String);
    printf("😄 parameterString - %s\n",[url parameterString].UTF8String);
    printf("😄 query - %s\n",[url query].UTF8String);
    printf("😄 fragment - %s\n",[url fragment].UTF8String);
    printf("😄 user - %s\n",[url user].UTF8String);
    printf("😄 password - %s\n",[url password].UTF8String);
    printf("\n-------- 😊URL END --------\n\n");
}

@end
