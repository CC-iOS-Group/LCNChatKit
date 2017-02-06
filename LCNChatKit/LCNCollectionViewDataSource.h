//
//  LCNCollectionViewDataSource.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LCNMessageLayout;

@protocol LCNCollectionViewDataSource <UICollectionViewDataSource>

@optional

- (NSArray<LCNMessageLayout *> *)collection:(UICollectionView *)collectionView loadMoreItemsCount:(NSInteger)count;

@end
