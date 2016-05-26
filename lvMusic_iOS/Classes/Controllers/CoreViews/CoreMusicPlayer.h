//
//  CoreMusicPlayer.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/26.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CoreMusicPlayerStatus)
{
    CoreMusicPlayerStatusUp,   // 播放器展开
    CoreMusicPlayerStatusDown  // 播放器缩小
};

@protocol CoreMusicPlayerDelegate <NSObject>

@end

@interface CoreMusicPlayer : UIView

- (instancetype)initWithSth;

@end

@interface MPBottomToolItem : NSObject

@property (nonatomic, strong) NSString * imgName;
@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) CGRect   up_frame;
@property (nonatomic, assign) CGRect   dn_frame;

@end