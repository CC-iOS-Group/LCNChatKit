//
//  LCGroupManagerDelegate.h
//  LittleCIMDemo
//
//  Created by shenhongbang on 16/9/10.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCGroupInfoModel.h"
#import "LCCrewModel.h"

@protocol LCGroupManagerDelegate <NSObject>

@optional
/**
 *  被邀请加入群聊（自动加入群聊，不需要自己同意）
 *
 *  @param groupInfo         群组信息
 *  @param members           加入群的成员数组
 *  @param inviterUserName   邀请人
 *
 */
- (void)didJoinedGroup:(LCGroupInfoModel *)groupInfo
               members:(NSArray <LCCrewModel *>*)members
               inviter:(LCCrewModel *)inviter;

/**
 *  收到群邀请（例：用户A邀请用户B入群,用户B接收到该回调）
 *
 *  @param groupInfo         群组信息
 *  @param inviter      邀请人
 *  @param inviteReason 邀请理由（可能为空）
 */
- (void)didReceiveGroupInvitation:(LCGroupInfoModel *)groupInfo
                          inviter:(LCCrewModel *)inviter
                     inviteReason:(NSString *)inviteReason;

/**
 *  邀请入群被同意
 *
 *  @param groupInfo  群信息（包括groupId,groupName）
 *  @param acceptFrom 受邀者
 */
- (void)beAcceptedInvitationToGroup:(LCGroupInfoModel *)groupInfo
                         acceptFrom:(LCCrewModel *)acceptFrom;

/**
 *  受邀者入群
 *
 *  @param groupInfo 群信息（包括groupId,groupName）
 *  @param invitee   受邀者
 *  @param inviter   邀请者
 */
- (void)inviteesDidJoinGroup:(LCGroupInfoModel *)groupInfo
                     invitee:(LCCrewModel *)invitee
                     inviter:(LCCrewModel *)inviter;

/**
 *  邀请入群被拒绝
 *
 *  @param groupInfo      群信息（包括groupId,groupName）
 *  @param declinedFrom   受邀者
 *  @param declinedReason 被拒原因
 */
- (void)beDeclinedInvitationToGroup:(LCGroupInfoModel *)groupInfo
                       declinedFrom:(LCCrewModel *)declinedFrom
                     declinedReason:(NSString *)declinedReason;

/**
 *  收到踢人广播（例：用户A将用户B踢出群，该群内所有用户收到该回调）
 *
 *  @param groupMembers 被踢出成员的数组
 *  @param groupInfo    群信息（包括groupId,groupName）
 *  @param actor        踢人执行者
 */
- (void)beKickedGroupMembers:(NSArray<LCCrewModel *> *)groupMembers
                       group:(LCGroupInfoModel *)groupInfo
                    byKicker:(LCCrewModel *)actor;

/**
 *  收到退群广播（例：用户A退出群，该群内所有用户收到该回调）
 *
 *  @param groupInfo 群信息（包括groupId,groupName）
 *  @param exiter    退群者
 */
- (void)didExitGroup:(LCGroupInfoModel *)groupInfo
              exiter:(LCCrewModel *)exiter;

/**
 *  收到解散群广播（例：用户A解散群，该群内所有用户收到该回调）
 *
 *  @param groupInfo 群信息（包括groupId,groupName）
 *  @param actor     解散者
 */
- (void)didDestroyGroup:(LCGroupInfoModel *)groupInfo
                  actor:(LCCrewModel *)actor;

/**
 *  收到转移群主广播（例：用户A将群主转移给用户B，该群内所有用户收到该回调）
 *
 *  @param groupInfo  群信息（包括groupId,groupName）
 *  @param newOwner   新的群主
 */
- (void)didHandoverGroup:(LCGroupInfoModel *)groupInfo
              toNewOwner:(LCCrewModel *)newOwner;

/**
 *  收到修改群名称广播（例：用户A修改群名称，该群内用户B收到该回调）
 *
 *  @param groupInfo 群信息（包括groupId,groupName）
 *  @param actor     群名称修改者
 */
- (void)didModifyGroupName:(LCGroupInfoModel *)groupInfo
                     actor:(LCCrewModel *)actor;

/**
 *  收到修改群成员昵称广播（例：用户A修改个人群昵称，该群内用户B收到该回调）
 *
 *  @param actor     修改群成员昵称的用户
 *  @param groupInfo 群信息（包括groupId,groupName）
 */
- (void)didModifyGroupNickName:(LCCrewModel *)actor
                         group:(LCGroupInfoModel *)groupInfo;

/**
 *  指定新管理员
 *
 *  @param admins    指定的新管理员数组
 *  @param groupInfo 群信息（包括groupId,groupName）
 *  @param actor     指定者
 */
- (void)didSetNewAdmins:(NSArray <LCCrewDetail *>*)admins
              groupInfo:(LCGroupInfoModel *)groupInfo
                  actor:(LCCrewModel *)actor;

/**
 *  废除管理员
 *
 *  @param abolishedAdmins 废除的管理员
 *  @param groupInfo       群信息（包括groupId,groupName）
 *  @param actor           指定者
 */
- (void)didAbolishedAdmins:(NSArray <LCCrewDetail *>*)abolishedAdmins
                 groupInfo:(LCGroupInfoModel *)groupInfo
                     actor:(LCCrewModel *)actor;

/**
 *  收到入群申请
 *
 *  @param groupInfo 群信息（包括groupId,groupName）
 *  @param asker     申请者
 *  @param reason    申请说明
 */
- (void)didReceiveApplyJoinGroup:(LCGroupInfoModel *)groupInfo
                           asker:(LCCrewModel *)asker
                          reason:(NSString *)reason;

/**
 *  被同意入群 发送给所有群成员
 *
 *  @param groupInfo    群信息（包括groupId,groupName）
 *  @param asker        申请者
 *  @param approveActor 处理者
 */
- (void)beApprovedJoinGroup:(LCGroupInfoModel *)groupInfo
                      asker:(LCCrewModel *)asker
               approveActor:(LCCrewModel *)approveActor;

/**
 *  被拒绝入群
 *
 *  @param groupInfo    群信息（包括groupId,groupName）
 *  @param refuseActor  处理者
 *  @param refuseReason 拒绝理由
 */
- (void)beRefusedJoinGroup:(LCGroupInfoModel *)groupInfo
               refuseActor:(LCCrewModel *)refuseActor
              refuseReason:(NSString *)refuseReason;

/**
 *  修改群描述
 *
 *  @param groupInfo    群信息（包括groupId,groupName）
 *  @param newGroupDescription  新的群描述
 *  @param actor 群描述修改者
 */
- (void)didChangeGroupDescription:(NSString *)newGroupDescription
                        groupInfo:(LCGroupInfoModel *)groupInfo
                            actor:(LCCrewModel *)actor;

@end
