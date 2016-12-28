//
//  LCTextMessageBodyModel.h
//  LittleCIM
//  @abstract 文本消息体
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"

@interface LCTextMessageBodyModel : LCMessageBodyModel

/**
 *  文本内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  创建文本实例
 *
 *  @param text 文本消息
 *
 *  @return 文本消息体实例
 */
+ (instancetype)textMessageBodyWithText:(NSString*)text;

/**
 *  初始化文本实例
 *
 *  @param text 文本消息
 *
 *  @return 文本消息体实例
 */
- (instancetype)initWithText:(NSString *)text;

@end
