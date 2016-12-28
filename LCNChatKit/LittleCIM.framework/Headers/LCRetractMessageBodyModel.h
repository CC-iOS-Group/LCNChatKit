//
//  LCRetractMessageBodyModel.h
//  LittleCIMDemo
//  @abstract 消息撤回消息体
//
//  Created by zhaojunjie on 16/9/23.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"

@interface LCRetractMessageBodyModel : LCMessageBodyModel

/**
 * 被撤回消息的会话标识
 */
@property (nonatomic, copy) NSString *retractConversationId;

/**
 * 被撤回消息的唯一标识
 */
@property (nonatomic, copy) NSString *retractMessageId;

/**
 * 被撤回消息后显示的文字内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  初始化撤回消息实例
 *
 *  @param retractMessageId      被撤回消息的唯一标识
 *  @param retractConversationId 被撤回消息的会话标识
 *
 *  @return 撤回消息实例
 */
- (instancetype)initWithConversationId:(NSString *)retractConversationId messageId:(NSString *)retractMessageId;

/**
 *  创建撤回消息实例
 *
 *  @param retractMessageId      被撤回消息的唯一标识
 *  @param retractConversationId 被撤回消息的会话标识
 *
 *  @return 撤回消息实例
 */
+ (instancetype)retractMessageBodyWithConversationId:(NSString *)retractConversationId messageId:(NSString *)retractMessageId;

@end
