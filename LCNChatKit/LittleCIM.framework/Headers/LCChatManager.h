//
//  LCChatManager.h
//  LittleCIM
//  @abstract 管理消息的收发，完成会话管理等功能

//  Created by zhaojunjie on 16/7/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@class LCMessageModel, LCError;

@protocol LCChatManagerDelegate <NSObject>

@optional
/**
 *  消息发送进度代理
 *
 *  @param progress 进度值，值域为0到1.0的浮点数
 *  @param message  该进度值所属的消息Model
 */
- (void)setProgress:(double)progress message:(LCMessageModel *)message;

/**
 *  消息发送结果
 *
 *  @param error   发送结果返回，若为nil,表示发送成功
 *  @param message 发送结果所属的消息Model
 */
- (void)completionState:(LCError *)error message:(LCMessageModel *)message;

/**
 *  接收消息
 *
 *  @param messages 消息数组(包括已读回执)
 */
- (void)didReceiveMessages:(NSArray <LCMessageModel *>*)messages;

@end

@interface LCChatManager : NSObject

@property (nonatomic, assign) id<LCChatManagerDelegate> delegate;

/**
 *  获取消息模块实例
 *
 *  @return  LCChatManager 实例
 */
+ (LCChatManager *) sharedInstance;

/**
 *  发送消息
 *
 *  @param message    发送的消息model(文本、图片、语音、视频、位置等)
 */
- (void)sendMessage:(LCMessageModel *)message;

/**
 *  取消正在发送的消息
 *
 *  @param messageId 被取消发送的消息的messageId
 *
 *  @return 返回取消操作状态：错误码或nil
 */
- (LCError *)cancelSendMessage:(NSString *)messageId;

/**
 *  暂停／恢复正在发送的消息
 *
 *  @param messageId 正在发送的消息的messageId
 *
 *  @return 错误码或nil
 */
- (LCError *)suspendOrResumeSendMessage:(NSString *)messageId;

/**
 *  转发消息
 *
 *  @param forwardConversationId  要转发消息的会话标识
 *  @param forwardMessageId       要转发的消息标识
 *  @param to                     要转发的用户名/群的groupId
 *  @param chatType               to的聊天类型（单聊/群聊）
 */
- (void)forwardMessageWithConversationId:(NSString *)forwardConversationId messageId:(NSString *)forwardMessageId to:(NSString *)to type:(LCChatType)chatType;

/**
 设置免打扰

 @param conversationId 会话id
 @param chatType       聊天类型
 @param isSilent       是否静默
 @param handler        结果回调
 */
- (void)setSilentWithConversationId:(NSString *)conversationId
                             isSilent:(BOOL)isSilent
                           chatType:(LCChatType)chatType
                            handler:(void(^)(LCError *error))handler;

@end
