//
//  LCNMessageLayout.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNMessageModel.h"

@interface LCNMessageLayout : NSObject

@property (nonatomic, strong) LCNMessageModel *model;

/**
 是否需要时间戳
 */
@property (nonatomic, assign) BOOL isShowTimeLabel;


/**
 是否需要状态栏
 */
@property (nonatomic, assign) BOOL isShowStatusLabel;

/**
 气泡大小
 */
@property (nonatomic, assign) CGSize mediaViewSize;

/**
 整个cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;


-(LCNMessageLayout *)initWithLCNMessageModel:(LCNMessageModel *) model preMessageModel:(LCNMessageModel *)preModel;

@end
