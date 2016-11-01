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
        bubbleImage = [UIImage imageNamed:@"rightBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(13, 2, 2, 5) resizingMode:UIImageResizingModeStretch];

    }
    else{
        bubbleImage = [UIImage imageNamed:@"leftBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(13, 5, 2, 2) resizingMode:UIImageResizingModeStretch];
    }
    
    //获取气泡蒙版
    [imageView setImage:bubbleImage];
    CALayer *layer = imageView.layer;
    
    return layer;
}

+ (UIImage *)bubbleImageIsOutgoing:(BOOL)isOutgoing{
    UIImage *bubbleImage = nil;
    if (isOutgoing) {
        bubbleImage = [UIImage imageNamed:@"rightBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(13, 2, 2, 5) resizingMode:UIImageResizingModeStretch];
        
    }
    else{
        bubbleImage = [UIImage imageNamed:@"leftBubble"];
        bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(13, 5, 2, 2) resizingMode:UIImageResizingModeStretch];
    }
    return bubbleImage;
}


@end
