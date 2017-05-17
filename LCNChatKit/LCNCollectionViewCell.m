//
//  LCNCollectionViewCell.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNCollectionViewCell.h"
#import "LCNMsgHelper.h"

@interface LCNCollectionViewCell()

@property (nonatomic, assign) NSTimeInterval pressTime;

@end

@implementation LCNCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _timeLabel = ({
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.lineBreakMode = NSLineBreakByTruncatingMiddle;
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 1;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor colorWithHexString:@"CECECE"];
            label.layer.cornerRadius = 5;
            label.clipsToBounds = YES;
            
            label;
        });
        
        _avatarImageView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            imageView;
        });
        
        CALayer *avatarBorder = [CALayer layer];
        avatarBorder.frame = _avatarImageView.bounds;
        avatarBorder.borderWidth = CGFloatFromPixel(1);
        avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
        avatarBorder.cornerRadius = _avatarImageView.height / 2;
        avatarBorder.shouldRasterize = YES;
        avatarBorder.rasterizationScale = kScreenScale;
        [_avatarImageView.layer addSublayer:avatarBorder];
        
        _nameLabel = ({
            YYLabel *label = [YYLabel new];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.displaysAsynchronously = YES;
            label.ignoreCommonProperties = NO;
            label.fadeOnAsynchronouslyDisplay = YES;
            label.fadeOnHighlight = YES;
            label.lineBreakMode = NSLineBreakByTruncatingMiddle;
            label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
            label.textAlignment = NSTextAlignmentLeft;//需要后期根据Layout布局
            label.textColor = [UIColor blackColor];
            
            label;
        });
        
        _mediaContainerrView = ({
            UIView *view = [UIView new];
            
            view;
        });
        
        _statusLabel = ({
            YYLabel *label = [YYLabel new];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.displaysAsynchronously = YES;
            label.ignoreCommonProperties = NO;
            label.fadeOnAsynchronouslyDisplay = YES;
            label.fadeOnHighlight = YES;
            label.lineBreakMode = NSLineBreakByTruncatingMiddle;
            label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
            label.textAlignment = NSTextAlignmentLeft;//需要后续根据Layout布局

            label;
        });
        
//        _unreadRedPointView = ({
//            UIImageView *imageView = [UIImageView new];
//            imageView.size = CGSizeMake(10, 10);
//            imageView.hidden = YES;
//            
//            imageView;
//        });
        
        _indicatorView =({
            UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [indicatorView startAnimating];
            indicatorView;
        });
        
        //add subviews
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.mediaContainerrView];
        [self.contentView addSubview:self.statusLabel];
//        [self.contentView addSubview:self.unreadRedPointView];
        [self.contentView addSubview:self.indicatorView];
        
    }
    return self;
}

-(void)setLayout:(LCNMessageLayout *)layout{
    
    _layout = layout;
    
    //添加时间戳
    if (layout.isShowTimeLabel) {
        self.timeLabel.text = [LCNMsgHelper timeStringWithNSDate:layout.model.date];
    }
    
    //添加用户名
    if (layout.model.isOutgoing) {
        self.nameLabel.textAlignment = NSTextAlignmentRight;
    }
    else{
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    self.nameLabel.text = layout.model.senderDisplayName;
    
    //添加头像
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:layout.model.senderAvatarImageUrl] options:YYWebImageOptionProgressiveBlur];
    
    //添加气泡
    [self.mediaContainerrView removeAllSubviews];
    [self.mediaContainerrView addSubview:[layout.model.mediaBubble mediaView]];
    
    //添加状态栏内容
    if (layout.isShowStatusLabel) {
        self.statusLabel.text = nil;
    }
    
}

#pragma mark - 手势控制
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint bubble_P = [t locationInView:_mediaContainerrView];
    if(CGRectContainsPoint(_mediaContainerrView.bounds, bubble_P)){
        _pressTime = t.timestamp;
        [self performSelector:@selector(handleLongPress) withObject:nil afterDelay:0.5];
        
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint avatar_p = [t locationInView:_avatarImageView];
    CGPoint name_p = [t locationInView:_nameLabel];
    CGPoint bubble_P = [t locationInView:_mediaContainerrView];
    
    //判断点击位置
    if(CGRectContainsPoint(_avatarImageView.bounds, avatar_p)){
        if([_delegate respondsToSelector:@selector(cellDidClickAvatar:)]){
            [_delegate cellDidClickAvatar:self];
        }
    }
    else if (CGRectContainsPoint(_nameLabel.bounds, name_p)){
        if([_delegate respondsToSelector:@selector(cellDidClickNameLabel:)]){
            [_delegate cellDidClickNameLabel:self];
        }
    }
    else if(CGRectContainsPoint(_mediaContainerrView.bounds, bubble_P)){
        
        //判断是否长按
        NSTimeInterval diff = (t.timestamp - _pressTime);
        if(diff > 0.5 && _pressTime > 0 ){
            [self handleLongPress];
        }
        else if(_pressTime == -1){
            
        }
        else{
            if([_delegate respondsToSelector:@selector(cellDidClickBubbleView:)]){
                [_delegate cellDidClickBubbleView:self];
            }
           
        }
        
    }
    else{
        
    }
    
    _pressTime = 0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(handleLongPress) object:nil];
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)handleLongPress{
    _pressTime = -1;
    if ([_delegate respondsToSelector:@selector(cellDidLongPressBubbleView:)]) {
        [_delegate cellDidLongPressBubbleView:self];
    }
}


@end























