//
//  LCPushManager.h
//  LittleCIM
//  @abstract 负责apns推送订阅，取消等功能
//
//  Created by zhaojunjie on 16/7/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCError;

@interface LCPushManager : NSObject

@property (nonatomic, strong) NSData *deviceToken; //设备token

/**
 *  获取推送模块实例
 *
 *  @return  LCPushManager 实例
 */
+ (LCPushManager *) sharedInstance;

/**
 *  向苹果服务器注册推送服务（注册了才能收到deviceToken）
 *  推送配置默认为Alert|Badge|Sound
 */
- (void)registerPushNotifications;

/**
 *  订阅推送
 *
 *  @param handler 结果回调
 */
- (void)subscribePushNotificationsWithHandler:(void(^)(LCError *error))handler;

/**
 *  取消订阅推送
 *
 *  @param handler 结果回调
 */
- (void)unsubscribePushNotificationsWithHandler:(void(^)(LCError *error))handler;

@end
