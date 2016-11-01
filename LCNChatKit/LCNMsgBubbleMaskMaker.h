//
//  LCNMsgBubbleMaskMaker.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/25.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCNMsgBubbleMaskMaker : UIView


/**
 制作气泡聊天的mask

 @param frame      气泡大小
 @param isOutgoing 左右气泡标志

 @return 返回mask
 */
+ (CALayer *)bubbleLayerWith:(CGRect)frame isOutgoing:(BOOL)isOutgoing;

+ (UIImage *)bubbleImageIsOutgoing:(BOOL)isOutgoing;

@end
