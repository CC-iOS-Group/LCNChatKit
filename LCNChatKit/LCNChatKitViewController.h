//
//  ViewController.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNChatKit.h"

@interface LCNChatKitViewController : UIViewController
<LCNCollectionViewDataSource,
LCNCollectionViewDelegate>

//CollectionView
@property (nonatomic, strong) LCNCollectionView *collectionView;

//CollectionView布局
@property (nonatomic, strong) LCNCollectionViewFlowLayout *springCollectionViewLayout;

//数据源
@property (nonatomic, strong) NSMutableArray<LCNMessageLayout *> *dataSource;

@end

