//
//  LCNUtils.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/4/26.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LLSoundVolumeLevel) {
    kLLSoundVolumeLevelHight = 13,
    kLLSoundVolumeLevelMiddle = 8,
    kLLSoundVolumeLevelLow = 3,
    kLLSoundVolumeLevelMute = 0
};

@interface LCNUtils : NSObject

//File
+ (NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory;

+ (NSString*)dataPath;

//Audio
+ (NSInteger)currentVolumeLevel;

@end
