//
//  LCNAudioRecordDelegate.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/2/9.
//  Copyright © 2017年 enrecul. All rights reserved.
//


/**
 该协议在录制的过程，用于提示用户录音过程中的各个情况
 */

#import <Foundation/Foundation.h>

@protocol LCNAudioRecordDelegate <NSObject>
@optional

//检查录音权限成功
- (void)audioRecordAuthorizationDidGranted;

//录音成功开始
- (void)audioRecordDidStartedWithError:(NSError *)error;

//录音音量发生变化
- (void)audioRecordDidUpdateVoiceMeter:(double)averagePower;

//录音时长发生变化，以秒为单位
- (void)audioRecordDurationDidChanged:(NSTimeInterval)duration;

//录音最长时间
- (NSTimeInterval)audioRecordMaxRecordTime;

//录音成功，返回音频文件路径及时长
- (void)audioRecordDidFinishSuccessed:(NSString *)voiceFilePath duration:(CFTimeInterval)duration;

- (void)audioRecordDidFailed;

- (void)audioRecordDidCancelled;

- (void)audioRecordDurationTooShort;

//当设置的最长录音时间到后，派发该消息，但不停止录音，由delegate停止录音
- (void)audioRecordDurationTooLong;


@end
