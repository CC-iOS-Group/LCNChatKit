//
//  ViewController.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNChatKit.h"
#import "LCNChatMessagesManager.h"

@interface LCNChatKitViewController : UIViewController
<LCNCollectionViewDataSource,
LCNCollectionViewDelegate,
LCNCollectionViewCellDelegate,
YYTextKeyboardObserver,
LCNInputBarDelegate>

//CollectionView
@property (nonatomic, strong) LCNCollectionView *collectionView;

//数据源管理类
 @property (nonatomic, strong) LCNChatMessagesManager *chatMessagesManager;

@end

