//
//  LCGroupManager.h
//  LittleCIM
//  @abstract 负责群组的管理，创建、删除群组，管理群组成员等功能
//
//  Created by zhaojunjie on 16/7/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCGroupManagerDelegate.h"

@class LCError,LCGroupInfoModel, LCCrewModel;


@interface LCGroupManager : NSObject

@property (nonatomic, assign) id<LCGroupManagerDelegate> delegate;

/**
 *  获取群组模块实例
 *
 *  @return  LCGroupManager 实例
 */
+ (LCGroupManager *) sharedInstance;

/**
 *  创建群
 *
 *  @param groupName            群名称
 *  @param desc                 群描述
 *  @param memberUsernameArray  群成员列表（不需要对方同意）
 *  @param inviteeUsernameArray 受邀者列表（需要对方同意）
 *  @param inviteReason         邀请理由 （可选参数）
 *  @param handler              结果回调
 */
- (void)createGroupWithName:(NSString *)groupName
                       desc:(NSString *)desc
                    members:(NSArray<NSString*>*)memberUsernameArray
                   invitees:(NSArray<NSString*>*)inviteeUsernameArray
               inviteReason:(NSString *)inviteReason
                    handler:(void(^)(LCError *error,LCGroupInfoModel *groupInfo))handler;

/**
 *  拉人入群
 *
 *  @param memberUsernameArray  被拉者列表（不需要对方同意）
 *  @param inviteeUsernameArray 受邀者列表（需要对方同意）
 *  @param groupId              群标识
 *  @param inviteReason         邀请理由 （可选参数）
 *  @param handler              结果回调
 */
- (void)addMembers:(NSArray<NSString*>*)memberUsernameArray 
          invitees:(NSArray<NSString*>*)inviteeUsernameArray
      inviteReason:(NSString *)inviteReason
           toGroup:(NSString *)groupId
           handler:(void(^)(LCError *error))handler;

/**
 *  受邀者同意入群
 *
 *  @param groupId         群标识
 *  @param inviterUserName 邀请者
 *  @param handler         结果回调
 */
- (void)acceptInvitationToGroup:(NSString *)groupId
                        inviter:(NSString *)inviterUserName
                        handler:(void(^)(LCError *error))handler;

/**
 *  受邀者拒绝入群
 *
 *  @param groupId         群标识
 *  @param inviterUserName 邀请者
 *  @param declineReason   拒绝原因（可选参数）
 *  @param handler         结果回调
 */
- (void)declineInvitationToGroup:(NSString *)groupId
                         inviter:(NSString *)inviterUserName
                   declineReason:(NSString *)declineReason
                         handler:(void(^)(LCError *error))handler;

/**
 *  主动入群-申请入群
 *
 *  @param groupId    群标识
 *  @param joinReason 入群理由(可选参数)
 *  @param requireApprove 是否需要同意
 *  @param handler    结果回调
 */
- (void)applyJoinGroup:(NSString *)groupId
            joinReason:(NSString *)joinReason
        requireApprove:(BOOL)requireApprove
               handler:(void(^)(LCError *error))handler;

/**
 *  主动入群-同意入群
 *
 *  @param groupId           群标识
 *  @param applicantUserName 申请入群者
 *  @param handler           结果回调
 */
- (void)approveJoinGroup:(NSString *)groupId
               applicant:(NSString *)applicantUserName
                 handler:(void(^)(LCError *error))handler;

/**
 *  主动入群-拒绝入群
 *
 *  @param groupId           群标识
 *  @param applicantUserName 申请入群者
 *  @param refuseReason      拒绝理由
 *  @param handler           结果回调
 */
- (void)declineJoinGroup:(NSString *)groupId
               applicant:(NSString *)applicantUserName
            refuseReason:(NSString *)refuseReason
                 handler:(void(^)(LCError *error))handler;

/**
 *  踢人请求
 *
 *  @param beKickedUserNames 被踢者用户名数组
 *  @param groupId           群标识
 *  @param handler           结果回调
 */
- (void)kickGroupMembers:(NSArray<NSString *>*)beKickedUserNames
                 inGroup:(NSString *)groupId
                 handler:(void(^)(LCError *error))handler;

/**
 *  退群请求
 *
 *  @param groupId 群标识
 *  @param handler 结果回调
 */
- (void)exitGroup:(NSString *)groupId
          handler:(void(^)(LCError *error))handler;

/**
 *  解散群
 *
 *  @param groupId 群标识
 *  @param handler 结果回调
 */
- (void)dissolveGroup:(NSString *)groupId
              handler:(void(^)(LCError *error))handler;

/**
 *  转移群主
 *
 *  @param groupId  群标识
 *  @param userName 被指定的新群主
 *  @param handler  结果回调
 */
- (void)handoverGroup:(NSString *)groupId
        toGroupMember:(NSString *)userName
              handler:(void(^)(LCError *error))handler;

/**
 *  修改群名称
 *
 *  @param newGroupName 新的群名称
 *  @param groupId      群标识
 *  @param handler      结果回调
 */
- (void)modifyGroupName:(NSString *)newGroupName
                inGroup:(NSString *)groupId
                handler:(void(^)(LCError *error))handler;

/**
 *  修改群成员昵称
 *
 *  @param newNickName   新的群昵称
 *  @param groupId       群标识
 *  @param handler       结果回调
 */
- (void)modifyGroupNickName:(NSString *)newNickName
                    inGroup:(NSString *)groupId
                    handler:(void(^)(LCError *error))handler;

/**
 修改群描述

 @param groupDesc 新的群描述
 @param groupId   群标识
 @param handler   结果回调
 */
- (void)modifyGroupDesc:(NSString *)groupDesc
                inGroup:(NSString *)groupId
                handler:(void(^)(LCError *error))handler;

/**
 *  获取群列表
 *
 *  @param handler 结果回调
 */
- (void)fetchAllGroups:(void(^)(LCError *error, NSArray <LCGroupInfoModel *>*groupsArray))handler;

/**
 *  获取群成员列表
 *
 *  @param groupId 群标识
 *  @param handler 结果回调
 */
- (void)fetchCrewList:(NSString *)groupId
              handler:(void(^)(LCError *error, NSArray <LCCrewDetail *>*crewsArray))handler;

/**
 *  指定管理员
 *
 *  @param adminUsername 被指定者
 *  @param groupId       群标识
 *  @param handler       结果回调
 */
- (void)setAdmins:(NSArray <NSString *>*)adminUsernames
         groupId:(NSString *)groupId
         handler:(void(^)(LCError *error))handler;

/**
 *  废除管理员
 *
 *  @param admins  要废除的管理员数组
 *  @param groupId 群标识
 *  @param handler 结果回调
 */
- (void)abolishAdmins:(NSArray <NSString *>*)admins
              groupId:(NSString *)groupId
              handler:(void(^)(LCError *error))handler;




@end


