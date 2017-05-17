//
//  LCNInputBar.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/11/9.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kInputBarHeight 50

@protocol LCNInputBarDelegate<NSObject>

- (void)LCNInpuBatHeightChanged:(CGFloat)currentTextviewHeight;

//录音相关回调
- (void)voiceRecordingShouldStart;

- (void)voiceRecordingShouldCancel;

- (void)voicRecordingShouldFinish;

- (void)voiceRecordingDidDraginside;

- (void)voiceRecordingDidDragoutside;

- (void)voiceRecordingTooShort;

@end

//===========================================

@interface LCNInputBar : UIView

@property (nonatomic, weak) id<LCNInputBarDelegate> delegate;

- (void)resetAllButton;

//当录音时间过长时，由APP主动取消录音按钮的按压事件，结束录音
- (void)cancelRecordButtonTouchEvent;

@end
