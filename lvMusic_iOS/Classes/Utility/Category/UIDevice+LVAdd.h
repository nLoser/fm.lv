//
//  UIDevice+LVAdd.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/23.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//  Look At 'YYKit/Base/UIKit/UIDevice+YYAdd.h'

#import <UIKit/UIKit.h>

@interface UIDevice (LVAdd)

#pragma mark - Device Infomation

/*! Device system version(e.g. 9.300000) */
+ (double)systemVersion;

/*! Whether the device is iPad/iPad mini */
@property (nonatomic, readonly) BOOL isPad;

/*! Whether the device is a simulator */
@property (nonatomic, readonly) BOOL isSimulator;

/*! Whether the device is jailbroken */
@property (nonatomic, readonly) BOOL isJailbroken;

/*! Whether the device can make phone calls */
@property (nonatomic, readonly) BOOL canMakePhoneCalls;

/**
  Device's machine model. e.g. "iPhone6,1","iPad4.6"
  @see http://theiphonewiki.com/wiki/Models
*/
@property (nonatomic, readonly) NSString * machineModel;

/*! Device's machine model name. e.g. "iPhone5s","iPad mini 2" */
@property (nonatomic, readonly) NSString * machineModelName;

/*! The system' startup time */
@property (nonatomic, readonly) NSDate * systemUptime;

#pragma mark - Network Infomation

/*! WIFI IP address of device (can be nil). e.g. "192.168.1.3" */
@property (nonatomic, readonly) NSString * ipAddressWIFI;

/*! Cell IP address of device (can be nil). e.g. "117.136.0.30"北京移动 */
@property (nonatomic, readonly) NSString * ipAddressCell;



@end
