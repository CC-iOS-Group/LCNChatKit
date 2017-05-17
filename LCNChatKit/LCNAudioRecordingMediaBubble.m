//
//  LCNAudioRecordingMediaBubble.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/5/17.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "LCNAudioRecordingMediaBubble.h"
#import "LCNMsgBubbleMaskMaker.h"

#define RECORD_ANIMATION_KEY @"RecordAnimate"


@interface LCNAudioRecordingMediaBubble()

@property (nonatomic, strong) UIView *cachedImageMediaView;

@property (nonatomic, strong) CAKeyframeAnimation *keyFrameAnimation;

@end

@implementation LCNAudioRecordingMediaBubble

- (UIView *)mediaView{
    
    if (_cachedImageMediaView == nil) {
        
        UIView *view = [UIView new];
        view.size = CGSizeMake(60, 40);
        
        //语音气泡
        UIImageView *bubbleView = [UIImageView new];
        bubbleView.contentMode = UIViewContentModeScaleToFill;
        bubbleView.size = CGSizeMake(60, 40);
        UIImage *bubbleImage = [LCNMsgBubbleMaskMaker bubbleImageIsOutgoing:YES];
        [bubbleView setImage:bubbleImage];
        [view addSubview:bubbleView];
        
        [bubbleView.layer addAnimation:self.keyFrameAnimation forKey:RECORD_ANIMATION_KEY];
        _cachedImageMediaView = view;
    }
    
    return _cachedImageMediaView;
}

- (CGSize)mediaViewDisplaySize{
    return CGSizeMake(60, 40);
}

#pragma mark - Private Method
- (CAKeyframeAnimation *)keyFrameAnimation {
    if (!_keyFrameAnimation) {
        _keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        _keyFrameAnimation.duration = 2;
        _keyFrameAnimation.repeatCount = HUGE_VALF;
        _keyFrameAnimation.removedOnCompletion = NO;
        _keyFrameAnimation.calculationMode = kCAAnimationLinear;
        _keyFrameAnimation.keyTimes = @[@(0), @(0.7), @(1)];
        _keyFrameAnimation.values = @[@(1), @(0.3), @(1)];
        _keyFrameAnimation.timingFunctions = @[
                                               [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                               ];
    }
    
    return _keyFrameAnimation;
}

@end
