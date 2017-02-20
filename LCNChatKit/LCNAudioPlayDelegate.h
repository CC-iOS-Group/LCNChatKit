//
//  LCNAudioPlayDelegate.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/2/9.
//  Copyright © 2017年 enrecul. All rights reserved.
//

/**
 该协议在音频播放中，回调播放相关情况
 */

#import <Foundation/Foundation.h>

@protocol LCNAudioPlayDelegate <NSObject>
@optional

- (void)audioPlayDidStarted:(id)userinfo;

//播放录音时，系统声音太小
- (void)audioPlayVolumeTooLow;

//发生播放错误时，播放Session同时结束
- (void)audioPlayDidFailed:(id)userinfo;

//播放结束时考虑到连续播放的需求，仅仅停止了当前播放，没有停止播放session
- (void)audioPlayDidStopped:(id)userinfo;

//播放结束，停止播放session
- (void)audioPlayDidFinished:(id)userinfo;

@end
