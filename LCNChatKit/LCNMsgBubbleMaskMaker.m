//
//  LCNMsgBubbleMaskMaker.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/25.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMsgBubbleMaskMaker.h"

@implementation LCNMsgBubbleMaskMaker

+ (CALayer *)bubbleLayerWith:(CGRect)frame isOutgoing:(BOOL)isOutgoing{
    
    //制作气泡视图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *bubbleImage = nil;
    if (isOutgoing) {
        bubbleImage = [UIImage imageNamed:@"outgoingBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 5, 5, 30) resizingMode:UIImageResizingModeStretch];

    }
    else{
        bubbleImage = [UIImage imageNamed:@"incomingBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 5, 5) resizingMode:UIImageResizingModeStretch];
    }
    
    //获取气泡蒙版
    [imageView setImage:bubbleImage];
    CALayer *layer = imageView.layer;
    
    return layer;
}

+ (UIImage *)bubbleImageIsOutgoing:(BOOL)isOutgoing{
    UIImage *bubbleImage = nil;
    if (isOutgoing) {
        bubbleImage = [UIImage imageNamed:@"outgoingBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 5, 5, 30) resizingMode:UIImageResizingModeStretch];
        
    }
    else{
        bubbleImage = [UIImage imageNamed:@"incomingBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 5, 5) resizingMode:UIImageResizingModeStretch];
    }
    return bubbleImage;
}


@end
