//
//  LCNUtils.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/4/26.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "LCNUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation LCNUtils

+ (NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory {
    NSString *path = [directory stringByAppendingPathComponent:folderName];
    NSURL *folderURL = [NSURL URLWithString:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error;
        [fileManager createDirectoryAtPath:path
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if (!error) {
            return folderURL;
        }else {
            NSLog(@"创建文件失败 %@", error.localizedFailureReason);
            return nil;
        }
        
    }
    return folderURL;
}

+ (NSString*)dataPath {
    static NSString *_dataPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataPath = [NSString stringWithFormat:@"%@/Library/appdata/chatbuffer", NSHomeDirectory()];
    });
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:_dataPath]){
        [fm createDirectoryAtPath:_dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    
    return _dataPath;
}


#pragma mark 获得当前的音量
+ (float)currentVolumn {
    float volume;
    //以下API已废弃
    //    UInt32 dataSize = sizeof(float);
    //
    //    AudioSessionGetProperty (kAudioSessionProperty_CurrentHardwareOutputVolume,
    //                             &dataSize,
    //                             &volume);
    volume = [AVAudioSession sharedInstance].outputVolume;
    
    return volume;
}

+ (NSInteger)currentVolumeLevel {
    return round(16 *[self currentVolumn]);
}


@end
