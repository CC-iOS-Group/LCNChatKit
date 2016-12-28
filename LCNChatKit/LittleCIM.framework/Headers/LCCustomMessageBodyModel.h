//
//  LCCustomMessageBodyModel.h
//  LittleCIMDemo
//  @abstract 自定义消息体
//
//  Created by zhaojunjie on 16/9/27.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"

@interface LCCustomMessageBodyModel : LCMessageBodyModel

/**
 * apns通知显示的文本内容
 */
@property (nonatomic, copy) NSString *notificationText;

/**
 * 自定义消息内容（可根据自己需求定义字典内容）
 */
@property (nonatomic, strong) NSDictionary <NSString *, NSString *> *customDic;

/**
 *  初始化自定义消息实例
 *
 *  @param customDic          自定义消息字典内容
 *  @param notificationText   apns通知显示的文本内容
 *
 *  @return 自定义消息实例
 */
- (instancetype)initWithCustomDic:(NSDictionary *)customDic notificationContent:(NSString *)notificationText;

/**
 *  创建自定义消息实例
 *
 *  @param customDic          自定义消息字典内容
 *  @param notificationText   apns通知显示的文本内容
 *
 *  @return 自定义消息实例
 */
+ (instancetype)customMessageBodyWithCustomDic:(NSDictionary *)customDic notificationContent:(NSString *)notificationText;

@end
