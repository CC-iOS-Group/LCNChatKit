//
//  LCNMediaItem.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNMediaBubble.h"

static const CGFloat kDefaultMediaViewDisplayWidth = 210.0f;
static const CGFloat kDefaultMediaViewDisplayHeight = 150.0f;

@implementation LCNMediaBubble


#pragma mark - LCNMediaItemProtocol
- (UIView *)mediaView{
    NSAssert(NO, @"Error! 需要在子类中实现此方法!");
    return nil;
}

- (CGSize)mediaViewDisplaySize{
    return CGSizeMake(kDefaultMediaViewDisplayWidth, kDefaultMediaViewDisplayHeight);
}

@end
