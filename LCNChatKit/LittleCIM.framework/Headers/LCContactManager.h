//
//  LCContactManager.h
//  LittleCIM
//  @abstract 负责好友的添加删除等功能
//
//  Created by zhaojunjie on 16/7/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCFriendModel;

@protocol LCContactManagerDelegate <NSObject>

@optional
/**
 *  收到好友请求（例：A申请B为好友，B会收到此回调）
 *
 *  @param requestId   请求id
 *  @param friendModel 申请者
 *  @param reason      申请理由
 */
- (void)applyFriendRequestId:(NSString *)requestId applicant:(LCFriendModel *)friendModel withReason:(NSString *)reason;

/**
 *  同意好友请求（例：A同意B的好友申请，B会收到此回调）
 *
 *  @param friendModel 同意申请的用户
 *  @param reason      理由
 */
- (void)beAgreeFriend:(LCFriendModel *)friendModel withReason:(NSString *)reason;

/**
 *  拒绝好友请求（例：A拒绝B的好友申请，B会收到此回调）
 *
 *  @param friendModel 拒绝申请的用户
 *  @param remark      拒绝理由
 */
- (void) beDeclineFriend:(LCFriendModel *)friendModel withReason:(NSString *)reason;

/**
 *  删除好友（例：A删除B，B会收到此回调）
 *
 *  @param friendModel 删除者
 *  @param reason      理由
 */
- (void)beRemoveFriend:(LCFriendModel *)friendModel withReason:(NSString *)reason;

@end

@class LCError, LCFriendBaseModel, LCFriendModel;

@interface LCContactManager : NSObject

@property (nonatomic, assign) id<LCContactManagerDelegate> delegate;

/**
 *  获取好友模块实例
 *
 *  @return  LCContactManager 实例
 */
+ (LCContactManager *) sharedInstance;

#pragma mark - 获取好友列表
/**
 *  获取好友列表
 *
 *  @param handler 好友列表
 */
- (void)syncFriendsWithHandler:(void(^)(LCError *error, NSArray<LCFriendModel*>* friendList))handler;

#pragma mark - 修改好友信息（备注名）
/**
 *  修改好友备注名
 *
 *  @param remarkName  好友备注名
 *  @param userName    好友用户名
 *  @param handler     结果回调
 */
- (void) modifyRemarkName:(NSString *)remarkName
             withUserName:(NSString *)userName
                  handler:(void(^)(LCError *error))handler;


#pragma mark - 申请好友
/**
 *  申请好友
 *
 *  @param friendUserName 好友用户名
 *  @param reason         申请理由
 *  @param handler        结果回调
 */
- (void) applyFriend:(NSString *)friendUserName
          withReason:(NSString *)reason
             handler:(void(^)(LCError *error))handler;

#pragma mark - 同意好友
/**
 *  同意好友请求
 *
 *  @param requestId 好友请求id
 *  @param handler   结果回调
 */
- (void) agreeFriendRequest:(NSString *)requestId
                    handler:(void(^)(LCError *error))handler;

#pragma mark - 拒绝好友
/**
 *  拒绝好友请求
 *
 *  @param requestId 好友请求id
 *  @param reason    拒绝理由
 *  @param handler   结果回调
 */
- (void) declineFriendRequest:(NSString *)requestId
                  withReason:(NSString *)reason
                     handler:(void(^)(LCError *error))handler;

#pragma mark - 删除好友
/**
 *  删除好友
 *
 *  @param friendUserName 好友用户名
 *  @param handler        结果回调
 */
- (void) removeFriend:(NSString *)friendUserName
              handler:(void(^)(LCError *error))handler;


#pragma mark - 设置联系人静默

/**
 设置好友静默

 @param isSilent       是否静默
 @param friendUsername 要静默的联系人用户名
 @param handler        结果回调
 */
- (void)setFriendSilent:(BOOL)isSilent
         friendUsername:(NSString *)friendUsername
                handler:(void(^)(LCError *error))handler;

@end

