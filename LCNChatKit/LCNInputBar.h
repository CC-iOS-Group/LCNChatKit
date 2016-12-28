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

@end

@interface LCNInputBar : UIView

@property (nonatomic, weak) id<LCNInputBarDelegate> delegate;

- (void)resetAllButton;

@end
