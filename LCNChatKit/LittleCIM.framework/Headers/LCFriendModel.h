//
//  LCFriendModel.h
//  LittleCIMDemo
//
//  Created by yyy on 16/9/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@interface LCFriendModel : NSObject

/**
 *  好友用户名
 */
@property (nonatomic, copy) NSString *userName;

/**
 *  好友昵称
 */
@property (nonatomic, copy) NSString *nickName;

/**
 *  好友备注名
 */
@property (nonatomic, copy) NSString *remarkName;

/**
 *  好友显示名（有备注名怎显示备注名，无则显示昵称）
 */
@property (nonatomic, copy, readonly) NSString *displayName;

/**
 *  好友有效性（YES:有效，NO:无效）
 */
@property (nonatomic, assign) BOOL enable;

/**
 *  好友更新时间
 */
@property (nonatomic, assign) NSTimeInterval modifyTime;

/**
 是否静默
 */
@property (nonatomic, assign) BOOL bSilent;

@end

@interface LCFriendRequestModel : LCFriendModel

/**
 * 好友请求ID
 */
@property (nonatomic, copy) NSString *requestId;

/**
 *  备注（请求理由）
 */
@property (nonatomic, copy) NSString *remark;

/**
 * 请求状态
 */
@property (nonatomic, assign) LCRequestStatus requestStatus;

@end
