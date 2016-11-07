//
//  LCNCollectionViewCellDelegate.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LCNCollectionViewCell;

@protocol LCNCollectionViewCellDelegate <NSObject>

@optional
- (void)cellDidClickAvatar:(LCNCollectionViewCell *)cell;

- (void)cellDidClickNameLabel:(LCNCollectionViewCell *)cell;

- (void)cellDidClickBubbleView:(LCNCollectionViewCell *)cell;

- (void)cellDidLongPressBubbleView:(LCNCollectionViewCell *)cell;

@end
