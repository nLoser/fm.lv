//
//  LvGlobal.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/6.
//  Copyright © 2016年 lvhongyang. All rights reserved.
/* !基本宏定义 */

#ifndef LvGlobal_h
#define LvGlobal_h

// 重新设置系统NSLog，不打印时间戳stderr：unix中标准输出屏幕(设备)文件
#if DEBUG
#define NSLog(format, ...) fprintf(stderr,"line:%d %s\t%s\n",__LINE__ , [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(...)
#endif

// 创建LV标准输出宏
#if DEBUG
#define LVLog(format, ...) NSLog(format, ## __VA_ARGS__)
#define BASE_INFO_LOG(info)   LVLog(@"-> %@ -> %@",NSStringFromSelector(_cmd),info);
#define BASE_ERROR_LOG(error) LVLog(@"-> %@ -> %@",NSStringFromSelector(_cmd),error);
#else
#define LVLog(format, ...)
#define BASE_INFO_LOG(info)
#define BASE_ERROR_LOG(error)
#endif

#endif /* LvGlobal_h */
