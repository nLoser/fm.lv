//
//  CoreMusicState.h
//  lvMusic_iOS
//
//  Created by LV on 16/5/30.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

typedef NS_ENUM(NSUInteger, CoreMusicPlayerBoundStatus)
{
    CoreMusicPlayerBoundStatusExpanded,   // The interface state is expanded
    CoreMusicPlayerBoundStatusShrinking   // The interface state is shrinking
};

#define kBottomMin_H 51.f  // The minimum height of 'bottomToolView'
#define kBottomMax_H 110.f // The maximum height of 'bottomToolView'

#define kDefaultCompressDuration 0.2
