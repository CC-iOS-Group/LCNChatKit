//
//  LCCrewModel.h
//  LittleCIMDemo
//  @abstract 群员结构model
//
//  Created by zhaojunjie on 16/8/30.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"
@class LCCrewDetail;

@interface LCCrewModel : NSObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *nick;

/**
 *  转换为 LCCrewDetail role 默认为Mebmber
 *
 *  @return 返回值
 */
- (LCCrewDetail *)detail;

@end

@interface LCCrewDetail : LCCrewModel


@property (nonatomic, assign) LCRole role;
@property (nonatomic, assign) LCRole oldRole;

@property (nonatomic, assign) BOOL   bSilent;

@property (nonatomic, assign) uint64_t created;

@property (nonatomic, assign) uint64_t modified;


@end

