//
//  UIDevice+LVAdd.m
//  lvMusic_iOS
//
//  Created by LV on 16/5/23.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <TargetConditionals.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import "UIDevice+LVAdd.h"
#import "NSString+LVAdd.h"

@implementation UIDevice (LVAdd)

+ (double)systemVersion
{
    __block double version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.doubleValue;
    });
    return version;
}

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED

- (BOOL)isPad
{
    __block BOOL pad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    });
    return pad;
}

///http://blog.csdn.net/flylovesky127/article/details/21159109
- (BOOL)isSimulator
{
#if (TARGET_IPHONE_SIMULATOR)
    return YES;
#else
    return NO;
#endif
}

///http://blog.csdn.net/sakulafly/article/details/21159257
- (BOOL)isJailbroken
{
    if ([self isSimulator]) return NO;
    
    // 1.通过越狱文件检测是越狱
    NSArray * jailbreak_tool_pathes = @[@"/Applications/Cydia.app",
                                        @"/private/var/lib/apt/",
                                        @"/private/var/lib/cydia",
                                        @"/private/var/stash"];
    for (NSString * path in jailbreak_tool_pathes) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return NO;
        }
    }
    
    FILE * bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    
    // 2.通过限制操作来检测是否越狱
    NSString * path = [NSString stringWithFormat:@"/private/%@",[NSString stringWithUUID]];
    if ([@"test" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        return YES;
    }
    return NO;
}

- (BOOL)canMakePhoneCalls
{
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}

#endif

- (NSString *)machineModel
{
    struct utsname systeminfo;
    uname(&systeminfo);
    return [NSString stringWithCString:systeminfo.machine encoding:NSUTF8StringEncoding];
}

- (NSString *)machineModelName
{
    __block NSString * name = @"iOS";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * model = [self machineModel];
        if (!model) return ;
        NSDictionary * dic = @{
          @"Watch1,1" : @"Apple Watch",
          @"Watch1,2" : @"Apple Watch",
          
          @"iPod1,1" : @"iPod touch 1",
          @"iPod2,1" : @"iPod touch 2",
          @"iPod3,1" : @"iPod touch 3",
          @"iPod4,1" : @"iPod touch 4",
          @"iPod5,1" : @"iPod touch 5",
          @"iPod7,1" : @"iPod touch 6",
          
          @"iPhone1,1" : @"iPhone 1G",
          @"iPhone1,2" : @"iPhone 3G",
          @"iPhone2,1" : @"iPhone 3GS",
          @"iPhone3,1" : @"iPhone 4 (GSM)",
          @"iPhone3,2" : @"iPhone 4",
          @"iPhone3,3" : @"iPhone 4 (CDMA)",
          @"iPhone4,1" : @"iPhone 4S",
          @"iPhone5,1" : @"iPhone 5",
          @"iPhone5,2" : @"iPhone 5",
          @"iPhone5,3" : @"iPhone 5c",
          @"iPhone5,4" : @"iPhone 5c",
          @"iPhone6,1" : @"iPhone 5s",
          @"iPhone6,2" : @"iPhone 5s",
          @"iPhone7,1" : @"iPhone 6 Plus",
          @"iPhone7,2" : @"iPhone 6",
          @"iPhone8,1" : @"iPhone 6s",
          @"iPhone8,2" : @"iPhone 6s Plus",
          @"iPhone8,4" : @"iPhone SE",
          
          @"iPad1,1" : @"iPad 1",
          @"iPad2,1" : @"iPad 2 (WiFi)",
          @"iPad2,2" : @"iPad 2 (GSM)",
          @"iPad2,3" : @"iPad 2 (CDMA)",
          @"iPad2,4" : @"iPad 2",
          @"iPad2,5" : @"iPad mini 1",
          @"iPad2,6" : @"iPad mini 1",
          @"iPad2,7" : @"iPad mini 1",
          @"iPad3,1" : @"iPad 3 (WiFi)",
          @"iPad3,2" : @"iPad 3 (4G)",
          @"iPad3,3" : @"iPad 3 (4G)",
          @"iPad3,4" : @"iPad 4",
          @"iPad3,5" : @"iPad 4",
          @"iPad3,6" : @"iPad 4",
          @"iPad4,1" : @"iPad Air",
          @"iPad4,2" : @"iPad Air",
          @"iPad4,3" : @"iPad Air",
          @"iPad4,4" : @"iPad mini 2",
          @"iPad4,5" : @"iPad mini 2",
          @"iPad4,6" : @"iPad mini 2",
          @"iPad4,7" : @"iPad mini 3",
          @"iPad4,8" : @"iPad mini 3",
          @"iPad4,9" : @"iPad mini 3",
          @"iPad5,1" : @"iPad mini 4",
          @"iPad5,2" : @"iPad mini 4",
          @"iPad5,3" : @"iPad Air 2",
          @"iPad5,4" : @"iPad Air 2",
          @"iPad6,3" : @"iPad Pro (9.7 inch)",
          @"iPad6,4" : @"iPad Pro (9.7 inch)",
          @"iPad6,7" : @"iPad Pro (12.9 inch)",
          @"iPad6,8" : @"iPad Pro (12.9 inch)",
          
          @"AppleTV2,1" : @"Apple TV 2",
          @"AppleTV3,1" : @"Apple TV 3",
          @"AppleTV3,2" : @"Apple TV 3",
          @"AppleTV5,3" : @"Apple TV 4",
          
          @"i386" : @"Simulator x86",
          @"x86_64" : @"Simulator x64",
        };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

// GMT 格林威治标准时间；(据时区转换对应时间，例如：CCD +8.00 中国标准时间)
- (NSDate*)systemUptime
{
    NSTimeInterval time2 = [self upTimeSystem];
    return [NSDate dateWithTimeIntervalSinceNow:(0 - time2)];
}

#pragma mark - Private method

- (time_t)upTimeSystem
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptime = -1;
    (void)time(&now);
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1
        && boottime.tv_sec != 0) {
        uptime = now - boottime.tv_sec;
    }
    return uptime;
}

/**
 *  获取CTL_HW 信息 (1G = 1048576000 B)
 *
 *  @param typeSpecifier CTL_HW 参数
 *
 *  @return CTL_HW 参数的相信信息
 */
- (int)getSystemInfo:(int)typeSpecifier
{
    size_t size = sizeof(int);
    size_t results ;
    int mib[2] = {CTL_HW,typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (int)results;
}

@end
