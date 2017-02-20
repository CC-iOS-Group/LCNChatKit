//
//  LCNCollectionViewLayout.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/22.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

/**
 Tip: 气泡弹簧效果，存在效率问题。暂时没有用到
 */

#import <UIKit/UIKit.h>

@interface LCNCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) BOOL springEnable;//弹性效果

@property (nonatomic, assign) CGFloat springDumping;
@property (nonatomic, assign) CGFloat springFrequency;
@property (nonatomic, assign) CGFloat resistanceFactor;

@end
