//
//  LCConversationModel.h
//  LittleCIMDemo
//
//  Created by shenhongbang on 16/8/26.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"
#import "LCMessageModel.h"

@interface LCConversationModel : NSObject

/**
 *  会话id
 */
@property (nonatomic, copy) NSString *conversationId;

/**
 *  会话名
 */
@property (nonatomic, copy) NSString *conversationName;

/**
 *  最新更新时间
 */
@property (nonatomic, assign) NSTimeInterval latestUpdateTime;

/**
 *  会话文本
 */
@property (nonatomic, copy) NSString *msgContent;

/**
 *  未读消息数
 */
@property (nonatomic, assign) NSInteger unreadNum;

/**
 *  聊天类型
 */
@property (nonatomic, assign) LCChatType chatType;

/**
 *  是否静音
 */
@property (nonatomic, assign) BOOL isMuted;

/**
 *  聊天类型
 */
@property (nonatomic, assign) LCChatStatus status;

/**
 *  最后一条消息id
 */
@property (nonatomic, copy) NSString *msgId;

/**
 *  会话扩展
 */
@property (nonatomic, strong) NSDictionary *ext;

+ (instancetype)conversationWithMessage:(LCMessageModel *)aMessage;

@end
