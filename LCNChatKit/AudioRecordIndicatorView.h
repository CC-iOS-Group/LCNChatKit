//
//  AudioRecordIndicatorView.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/5/16.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AudioRecordIndicatorStatus) {
    AudioRecordIndicatorStatus_Recording,
    AudioRecordIndicatorStatus_Canel,
};

@interface AudioRecordIndicatorView : UIView

- (void)show;

- (void)hide;

- (void)setCurrentRecordIndicatorStatus:(AudioRecordIndicatorStatus) status;

- (void)setCurrentVoiceVolume:(double)volume;

@end
