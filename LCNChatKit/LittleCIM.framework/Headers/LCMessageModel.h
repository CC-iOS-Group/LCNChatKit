//
//  LCMessageModel.h
//  LittleCIM
//  @abstract 聊天消息Model
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCMessageBodyModel.h"
#import "LCCommonEnum.h"

@interface LCMessageModel : NSObject

/**
 *  消息的唯一标识符
 */
@property (nonatomic, copy) NSString *messageId;

/**
 *  消息的发送方用户名
 */
@property (nonatomic, copy) NSString *fromUsername;

/**
 *  消息的发送方昵称
 */
@property (nonatomic, copy) NSString *fromNickname;

/**
 *  消息的接收方(用户名/群的groupId）
 */
@property (nonatomic, copy) NSString *to;

/**
 群发接收者用户名数组
 */
@property (nonatomic, strong) NSArray <NSString *>*toUsernames;

/**
 *  会话的唯一标识符(单聊为接收方用户名，群聊为群groupId)
 */
@property (nonatomic, copy) NSString *conversationId;

/**
 *  会话名称(单聊为接收方显示名（昵称/备注名），群聊为群名称)
 */
@property (nonatomic, copy) NSString *conversationName;
/**
 *  消息时间
 */
@property (nonatomic, assign) NSTimeInterval date;

/**
 *  聊天类型
 */
@property (nonatomic, assign) LCChatType chatType;

/**
 *  消息体
 */
@property (nonatomic, strong) LCMessageBodyModel *messageBodyModel;

/**
 *  消息状态
 */
@property (nonatomic, assign) LCChatStatus  status;

/**
 *  是否阅后即焚
 */
@property (nonatomic, assign) BOOL burnAfterRead;

/**
 *  是不是自己发送的消息
 */
@property (nonatomic, assign) BOOL isSend;

/**
 *  在会话列表显示的消息文本， 文本消息显示text， 图片消息显示 ‘图片’， 语音消息显示 ‘语音’…………
 */
@property (nonatomic, copy, readonly) NSString *content;

/**
 *  创建消息实例
 *
 *  @param body            消息体
 *  @param to              消息接收者(用户名/群的groupId）
 *  @param chatType        聊天类型
 *
 *  @return 消息实例
 */
- (instancetype)initWithBody:(LCMessageBodyModel *)body to:(NSString *)to type:(LCChatType)chatType;

+ (instancetype)messageWithBody:(LCMessageBodyModel *)body to:(NSString *)to type:(LCChatType)chatType;

/**
 创建群发消息实例

 @param body        消息体
 @param toUsernames 消息接收者数组

 @return 消息实例
 */
+ (instancetype)messageWithBody:(LCMessageBodyModel *)body toUsernames:(NSArray <NSString *>*)toUsernames;

- (id)init DEPRECATED_ATTRIBUTE;

@end
