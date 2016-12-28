//
//  LCHistoryManager.h
//  LittleCIMDemo
//  @abstract 历史消息模块
//
//  Created by zhaojunjie on 16/9/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@class LCError,LCMessageModel,lcchatt;

@interface LCHistoryManager : NSObject

/**
 *  获取历史消息模块实例
 *
 *  @return  LCHistoryManager 实例
 */
+ (LCHistoryManager *) sharedInstance;

/**
 获取单/群聊历史消息

 @param conversationId 会话标识(单聊为接收方用户名，群聊为群groupId)
 @param limit          单次请求最大条数（不超过100条）
 @param chatType       聊天类型（单/群聊）
 @param beginMessageId 查询起点MessageId，（第一次查询为nil，后续为handler回调中的lastMessageId）
 @param handler        结果回调消息数组
 */
- (void)getHistoryMessagesWithConversationId:(NSString *)conversationId
                                       limit:(uint32_t)limit
                                    chatType:(LCChatType)chatType
                                   beginMessageId:(NSString *)beginMessageId
                                     handler:(void (^)(LCError *error, NSArray<LCMessageModel *> *messages, NSString *lastMessageId))handler;

/**
 删除历史消息

 @param conversationId     会话标识(单聊为接收方用户名，群聊为群groupId)
 @param chatType           聊天类型（单/群聊）
 @param beginMessageId     起始messageId
 @param endMessageId       结束messageId
 @param handler            结果回调
 */
- (void)deleteHistoryMessagesWithConversationId:(NSString *)conversationId
                                       chatType:(LCChatType)chatType
                                 beginMessageId:(NSString *)beginMessageId
                                   endMessageId:(NSString *)endMessageId
                                        handler:(void(^)(LCError *error))handler;

/**
 删除所有历史消息

 @param conversationId 会话标识(单聊为接收方用户名，群聊为群groupId)
 @param chatType       聊天类型（单/群聊）
 @param handler        结果回调
 */
- (void)deleteAllHistoryMessagesWithConversationId:(NSString *)conversationId
                                            chatType:(LCChatType)chatType
                                             handler:(void(^)(LCError *error))handler;


@end
