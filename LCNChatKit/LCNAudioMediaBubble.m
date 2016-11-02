//
//  LCNAudioMediaItem.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNAudioMediaBubble.h"
#import "LCNMsgHelper.h"
#import "LCNMsgBubbleMaskMaker.h"

@interface LCNAudioMediaBubble()

@property (nonatomic, strong) UIImageView *speakerView;

/**
 用于缓存生成过的聊天气泡
 */
@property (nonatomic, strong) UIView *cachedImageMediaView;


@end

@implementation LCNAudioMediaBubble

- (instancetype)initWithNSData:(NSData *)audioData duration:(CGFloat)duration{
    self = [super init];
    if (self) {
        _audioData = audioData;
        _duration = duration;
    }
    return self;
}

- (instancetype)initWithDownloadLink:(NSString *)link duration:(CGFloat)duration{
    self = [super init];
    if (self) {
        _downloadLink = link;
        _duration = duration;
    }
    return self;
}


-(UIView *)mediaView{
    if (!_cachedImageMediaView) {
    
        CGFloat bubbleLength = [LCNMsgHelper audioBubbleLengthCalculatorWithDuration:_duration];
        
        UIView *view = [UIView new];
        view.size = CGSizeMake(bubbleLength+40, 40);
        
        //语音气泡
        UIImageView *bubbleView = [UIImageView new];
        bubbleView.contentMode = UIViewContentModeScaleToFill;
        //计算语音气泡长度
        bubbleView.size = CGSizeMake(bubbleLength, 40);
        UIImage *bubbleImage = [LCNMsgBubbleMaskMaker bubbleImageIsOutgoing:self.isOutgoing];
        [bubbleView setImage:bubbleImage];
        [view addSubview:bubbleView];
        
        //播放动画
        _speakerView = [UIImageView new];
        _speakerView.size = CGSizeMake(20, 20);
        [view addSubview:_speakerView];
        
        //语音长度label
        UILabel *durationLabel = [UILabel new];
        durationLabel.size = CGSizeMake(40, 15);
        durationLabel.font = [UIFont systemFontOfSize:15.0f];
        durationLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        [view addSubview:durationLabel];
        
        if (self.isOutgoing){
            bubbleView.top = 0;
            bubbleView.left = 40;
            durationLabel.frame = CGRectMake(0, 20, 40, 15);
            durationLabel.textAlignment = NSTextAlignmentRight;
            
            _speakerView.left = 40+bubbleLength-15-20;
            _speakerView.top = 10;
            [_speakerView setImage:[UIImage imageNamed:@"speaker2-1"]];
        }
        else{
            bubbleView.top = 0;
            bubbleView.left = 0;
            durationLabel.frame = CGRectMake(bubbleLength, 20, 40, 15);
            durationLabel.textAlignment = NSTextAlignmentLeft;
            
            _speakerView.left = 15;
            _speakerView.top = 10;
            [_speakerView setImage:[UIImage imageNamed:@"speaker1"]];
        }
        
        durationLabel.text = [NSString stringWithFormat:@"%d\"",(int)_duration/1000];
        
        
        _cachedImageMediaView = view;
    }

    return _cachedImageMediaView;
}

-(CGSize)mediaViewDisplaySize{
    CGFloat bubbleLength = [LCNMsgHelper audioBubbleLengthCalculatorWithDuration:_duration];
    return CGSizeMake(bubbleLength + 40, 40);

}

#pragma mark - Public Method
- (void)startAnimation{
    NSArray *imageArray = nil;
    if (self.isOutgoing) {
        imageArray = @[[UIImage imageNamed:@"speaker2-3"],[UIImage imageNamed:@"speaker2-2"],[UIImage imageNamed:@"speaker2-1"]];
    }
    else{
        imageArray = @[[UIImage imageNamed:@"speaker3"],[UIImage imageNamed:@"speaker2"],[UIImage imageNamed:@"speaker1"]];

    }
    _speakerView.animationImages = imageArray;
    _speakerView.animationDuration = 1;
    _speakerView.animationRepeatCount = 0;
    
    [_speakerView startAnimating];
}

- (void)stopAnimation{
    [_speakerView stopAnimating];
    if (self.isOutgoing) {
        [_speakerView setImage:[UIImage imageNamed:@"speaker2-1"]];
    }
    else{
        [_speakerView setImage:[UIImage imageNamed:@"speaker1"]];
    }
    
}

@end
