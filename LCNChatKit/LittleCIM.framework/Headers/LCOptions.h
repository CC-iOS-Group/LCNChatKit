//
//  LCOptions.h
//  LittleCIM
//  @abstract SDK的设置选项
//
//  Created by zhaojunjie on 16/8/3.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@interface LCOptions : NSObject

/**
 *  注册的appkey
 */
@property (nonatomic, strong) NSString *appkey;

/**
 *  注册生成的appkeyPassword
 */
@property (nonatomic, strong) NSString *appkeyPassword;

/**
 *  是否自动登录, 默认为NO，需在登录成功后进行设置
 *
 *  设置的值会保存到本地。初始化LCOptions时，首先获取本地保存的值，若本地无保存值，则默认为NO.
 *
 */
@property (nonatomic, assign) BOOL bIsAutoLogin;

/**
 *  在控制台输出日志级别，默认为LCLogLevelAll输出所有日志
 */
@property (nonatomic, assign) LCLogLevel logLevel;

/**
 *  是否把日志写入到文件，默认为NO
 */
@property (nonatomic, assign) BOOL bWriteLogToFile;

/**
 *  是否为推送调试模式，默认为NO
 */
@property (nonatomic, assign) BOOL bApnsDevelopPattern;

/**
 *  创建设置选项实例
 *
 *  @param appkey         注册的appkey（从官网上获取）
 *  @param appkeyPassword appkey密码（从官网上获取）
 *
 *  @return 设置选项实例
 */
+ (instancetype)optionsWithAppkey:(NSString *)appkey appkeyPassword:(NSString *)appkeyPassword;

@end
