//
//  LCReadReceiptMessageBodyModel.h
//  LittleCIMDemo
//  @abstract 已读回执消息体
//
//  Created by zhaojunjie on 16/9/21.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"

@interface LCReadReceiptMessageBodyModel : LCMessageBodyModel

/**
 * 该回执对应消息的会话标识
 */
@property (nonatomic, copy) NSString *receiptConversationId;

/**
 * 该回执对应消息的唯一标识
 */
@property (nonatomic, copy) NSString *receiptMessageId;

/**
 *  初始化已读回执消息实例
 *
 *  @param receiptConversationId 该回执对应消息的会话标识
 *  @param receiptMessageId 该回执对应消息的唯一标识
 *
 *  @return 已读回执消息实例
 */
- (instancetype)initWithConversationId:(NSString *)receiptConversationId messageId:(NSString *)receiptMessageId;

/**
 *  创建已读回执消息实例
 *
 *  @param receiptConversationId 该回执对应消息的会话标识
 *  @param receiptMessageId 该回执对应消息的唯一标识
 *
 *  @return 已读回执消息实例
 */
+ (instancetype)readReceiptMessageBodyWithConversationId:(NSString *)receiptConversationId messageId:(NSString *)receiptMessageId;

@end
