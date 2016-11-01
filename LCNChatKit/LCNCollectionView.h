//
//  LCNCollectionView.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNCollectionViewDataSource.h"
#import "LCNCollectionViewDelegate.h"

@interface LCNCollectionView : UICollectionView


@property (nonatomic, weak, nullable) id<LCNCollectionViewDataSource> dataSource;

@property (nonatomic, weak, nullable) id<LCNCollectionViewDelegate> delegate;

@end
