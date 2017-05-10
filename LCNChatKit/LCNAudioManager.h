//
//  LCNAudioManager.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/2/8.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCNAudioRecordDelegate.h"
#import "LCNAudioPlayDelegate.h"
#import <AVFoundation/AVFoundation.h>

//录音错误
typedef NS_ENUM(NSInteger, LCNErrorRecordType) {
    kLCNErrorRecordTypeAuthorizationDenied,
    kLCNErrorRecordTypeInitFailed,
    kLCNErrorRecordTypeCreateAudioFileFailed,
    kLCNErrorRecordTypeMultiRequest,
    kLCNErrorRecordTypeRecordError,
};

//播放错误
typedef NS_ENUM(NSInteger, LCNErrorPlayType) {
    kLCNErrorPlayTypeInitFailed = 0,
    kLCNErrorPlayTypeFileNotExist,
    kLCNErrorPlayTypePlayError,
};

@interface LCNAudioManager : NSObject

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) BOOL isPlaying;

+(instancetype)sharedManager;

//录音
- (void)requestRecordPermission:(void (^)(AVAudioSessionRecordPermission recordPermission))callback;

- (void)startRecordingWithDelegate:(id<LCNAudioRecordDelegate>)delegate;

- (void)stopRecording;

- (void)cancelRecording;

//播放
- (void)startPlayingWithPath:(NSString *)aFilePath
                    delegate:(id<LCNAudioPlayDelegate>)delegate
                    userInfo:(id)userinfo
             continuePlaying:(BOOL)continuePlaying;

//关闭整个播放Session
- (void)stopPlaying;

//仅仅停止当前文件的播放，不关闭Session
- (void)stopCurrentPlaying;


@end
