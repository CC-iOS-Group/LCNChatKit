//
//  LCGroupInfoModel.h
//  LittleCIMDemo
//  @abstract 
//
//  Created by zhaojunjie on 16/8/29.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@class LCCrewModel;

@interface LCGroupInfoModel : NSObject

/**
 *  群唯一标识
 */
@property (nonatomic, copy) NSString *groupId;

/**
 *  群名称
 */
@property (nonatomic, copy) NSString *groupName;

/**
 *  群人数
 */
@property (nonatomic, assign) NSInteger memberCount;

/**
 *  群创建时间
 */
@property (nonatomic, assign) NSTimeInterval createTime;

/**
 *  群更新时间
 */
@property (nonatomic, assign) NSTimeInterval modifyTime;

/**
 *  群有效性（YES:有效，NO:无效）
 */
@property (nonatomic, assign) BOOL bEnable;

/**
 *  群主
 */
@property (nonatomic, strong) LCCrewModel *owner;

/**
 *  群成员
 */
@property (nonatomic, strong) NSArray<LCCrewModel *> *members;

/**
 *  本人在群里的昵称
 */
@property (nonatomic, copy) NSString *inGroupNick;

/**
 *  本人在群里的角色
 */
@property (nonatomic, assign) LCRole role;

/**
 群描述
 */
@property (nonatomic, copy) NSString *desc;

/**
 是否静默
 */
@property (nonatomic, assign) BOOL bSilent;

@end
