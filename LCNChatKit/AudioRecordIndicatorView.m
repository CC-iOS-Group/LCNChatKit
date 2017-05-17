//
//  AudioRecordIndicatorView.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/5/16.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "AudioRecordIndicatorView.h"

@interface AudioRecordIndicatorView()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) YYLabel *label;

@end

@implementation AudioRecordIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
        self.layer.cornerRadius = 20;
        self.clipsToBounds = YES;
        
        
        _leftImageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(0, 0, self.width/2, self.width/4*3);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.image = [UIImage imageNamed:@"RecordingBkg"];
            imageView;
        });
        
        _rightImageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(self.width/2, 0, self.width/2, self.width/4*3);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.image = [UIImage imageNamed:@"RecordingSignal001"];
            imageView;
        });
    
        _imageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(0, 0, self.width, self.width/4*3);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.image = [UIImage imageNamed:@"RecordCancel"];
            imageView;
        });
        
        _label = ({
            YYLabel *label = [[YYLabel alloc] init];
            label.frame = CGRectMake(10, self.width/4*3 + 10, self.width - 10*2, self.width/4 - 20);
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.layer.cornerRadius = 4;
            label.clipsToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
        
        
        [self addSubview:_leftImageView];
        [self addSubview:_rightImageView];
        [self addSubview:_imageView];
        [self addSubview:_label];
        
    }
    return self;
}

- (void)show{
    self.hidden = NO;
}
- (void)hide{
    self.hidden = YES;
}

- (void)setCurrentRecordIndicatorStatus:(AudioRecordIndicatorStatus) status{
    if (status == AudioRecordIndicatorStatus_Recording) {
        _leftImageView.hidden = NO;
        _rightImageView.hidden = NO;
        _imageView.hidden = YES;
        _label.text = @"手指上滑，取消发送";
        _label.backgroundColor = nil;

        
    }
    else if(status == AudioRecordIndicatorStatus_Canel){
        _leftImageView.hidden = YES;
        _rightImageView.hidden = YES;
        _imageView.hidden = NO;
        _label.text = @"松开手指，取消发送";
        _label.backgroundColor = [UIColor redColor];
    }
    else{
        
    }
}

- (void)setCurrentVoiceVolume:(double)volume{
    int num = @(volume).intValue;
    num = (num == 0) ? 1 : num;
    num = (num > 8) ? 8 : num;
    NSString *imageName = [NSString stringWithFormat:@"RecordingSignal00%d",num];
    _rightImageView.image = [UIImage imageNamed:imageName];
}

@end
