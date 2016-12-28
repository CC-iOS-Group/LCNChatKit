//
//  LCClient.h
//  LittleCIM
//  @abstract 公共模块，管理登录、退出、连接等功能，及获取其他模块的入口
//
//  Created by zhaojunjie on 16/7/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@class LCOptions,LCChatManager,LCGroupManager,LCContactManager,LCPushManager,LCDBManager,LCError, LCUserInfoModel, LCHistoryManager;

@protocol LCClientDelegate <NSObject>

@optional

/**
 *  SDK连接服务器的状态变化代理回调
 *
 *  有以下两种情况，会引起该方法的调用
 *  1. 登录成功后，无法上网（无网络或假在线情况下）时,会调用该回调
 *  2. 登录成功后，连接上网络时，会调用该回调
 *
 *  @param connectionStatus 当前连接状态
 */
- (void)didConnectionStateChanged:(LCConnectionStatus)connectionStatus;

/**
 *  自动登录代理回调
 *
 *  @param error         错误信息
 *  @param userInfoModel 用户信息
 */
- (void)didAutoLoginWithError:(LCError *)error userInfo:(LCUserInfoModel *)userInfoModel;

/**
 *  当前登录账号在其它设备登录时会接收到该代理回调
 */
- (void)didLoginFromOtherDevice;

@end

@interface LCClient : NSObject

/**
 *  SDK配置项
 */
@property (nonatomic, strong) LCOptions *options;

/**
 *  聊天模块
 */
@property (nonatomic, strong, readonly) LCChatManager *chatManager;

/**
 *  群组模块
 */
@property (nonatomic, strong, readonly) LCGroupManager *groupManager;

/**
 *  联系人模块
 */
@property (nonatomic, strong, readonly) LCContactManager *contactManager;

/**
 *  推送模块
 */
@property (nonatomic, strong, readonly) LCPushManager *pushManager;

/**
 *  数据库模块
 */
@property (nonatomic, strong, readonly) LCDBManager *dbManager;

/**
 *  历史消息模块
 */
@property (nonatomic, strong, readonly) LCHistoryManager *historyManager;

@property (nonatomic, assign) id<LCClientDelegate> delegate;

/**
 *  获取公共模块实例
 *
 *  @return return LCClient 实例
 */
+ (LCClient *) sharedInstance;

/**
 *  初始化SDK
 *
 *  @param options SDK配置项
 *  @param handler 结果回调
 */
- (void)initializeSDKWithOptions:(LCOptions *)options handler:(void(^)(LCError *error))handler;

/**
 *  注册
 *
 *  @param userName 用户名
 *  @param password 密码
 *  @param nickName 用户昵称(可选参数)
 *  @param phone    手机号（可选参数）
 *  @param handler  结果回调
 */
- (void)createAccountWithUserName:(NSString *)userName password:(NSString *)password nickName:(NSString *)nickName phone :(NSString *)phone handler:(void(^)(LCError *error))handler;
/**
 *  登录
 *
 *  @param userName 用户名/手机号
 *  @param password 密码
 *  @param handler  结果回调（错误码，用户信息）
 */
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password handler:(void(^)(LCError *error,LCUserInfoModel *userInfoModel))handler;

/**
 *  退出登录 （（无网络也退出成功，该函数调用后SDK不再主动重连服务器）
 *
 *  @param handler   结果回调
 */
- (void)logoutWithHandler:(void(^)(LCError *error))handler;

/**
 *  获取当前用户个人信息
 *
 *  @param handler  结果回调
 */
- (void)fetchCurrentUserInfo:(void(^)(LCError *error, LCUserInfoModel *userModel))handler;

/**
 *  获取用户个人信息
 *
 *  @param userName 用户名
 *  @param handler  结果回调
 */
- (void)fetchUserInfoWithUserName:(NSString *)userName
                        handler:(void(^)(LCError *error, LCUserInfoModel *userModel))handler;

/**
 *  修改个人昵称
 *
 *  @param userNick      新的昵称
 *  @param handler       结果回调
 */
- (void)modifyUserNick:(NSString *)userNick handler:(void(^)(LCError *error))handler;

/**
 *  修改个人密码
 *
 *  @param password      新的密码
 *  @param handler       结果回调
 */
- (void)modifyPassword:(NSString *)password handler:(void(^)(LCError *error))handler;

/**
 *  修改个人手机号
 *
 *  @param phone         新的手机号
 *  @param handler       结果回调
 */
- (void)modifyPhone:(NSString *)phone handler:(void(^)(LCError *error))handler;

/**
 *  搜索用户
 *
 *  @param searchKey  搜索关键字
 *  @param  offset  分页返回的起始偏移量
 *  @param limit    每页的条数
 *  @param handler  结果回调（错误码，每页返回的用户数组，所有分页加起来的用户总数）
 */
- (void)userSearchWithSearchKey:(NSString *)searchKey
                         offset:(uint32_t)offset
                          limit:(uint32_t)limit
                        handler:(void(^)(LCError *error, NSArray<LCUserInfoModel *>*userInfoArray, uint32_t totalCount))handler;

@end
