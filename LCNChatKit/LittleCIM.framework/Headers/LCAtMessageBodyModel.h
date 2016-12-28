//
//  LCAtMessage.h
//  LittleCIMDemo
//  @abstract At消息体，用于发送群文本消息
//
//  Created by zhaojunjie on 16/9/13.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"

@interface LCAtMessageBodyModel : LCMessageBodyModel

/**
 *  @成员用户名数组
 */
@property(nonatomic, strong) NSArray<NSString*> *atMemberArray;

/**
 *  文本内容
 */
@property (nonatomic, copy) NSString *text;

/**
 是否是@所有人，默认为NO， 若为YES，则 atMemberArray 无效
 */
@property (nonatomic, assign) BOOL bIsAtAll;

/**
 *  初始化@消息实例
 *
 *  @param atMemberArray @成员用户名数组
 *  @param text          文本消息
 *
 *  @return At消息实例
 */
- (instancetype)initWithMembers:(NSArray<NSString*> *)atMemberArray Text:(NSString *)text;

/**
 *  创建@消息实例
 *
 *  @param atMemberArray @成员用户名数组
 *  @param text          文本消息
 *
 *  @return At消息实例
 */
+ (instancetype)atMessageBodyWithMembers:(NSArray<NSString*> *)atMemberArray Text:(NSString *)text;

/**
 创建 @所有人 的消息实例

 @param text 文本消息

 @return At消息实例
 */
+ (instancetype)atMessageBodyForAllWithText:(NSString *)text;

@end
