//
//  LCDBProManager.h
//  LittleCIMDemo
//
//  Created by shenhongbang on 16/8/25.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@class LCMessageModel, LCResendMessageModel, LCConversationModel, LCGroupInfoModel, LCCrewModel, LCCrewDetail, LCFriendModel, LCFriendRequestModel, LCUserInfoShared,LCUserInfoModel;

@interface LCDBManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  当前会话id
 */
@property (nonatomic, copy) NSString *currentConversationId;


/**
 *  创建数据库
 *
 *  @param aName 数据库名称
 */
- (void)createDBWithName:(NSString *)aName;

#pragma mark - 消息表

/**
 *  更新或插入一条消息
 *
 *  @param aMessage 要更新的消息
 *  @param aGuid 服务端消息标识
 *
 *  @return 是否更新成功
 */
- (BOOL)insertOrUpdateMessage:(LCMessageModel *)aMessage
                         guid:(int64_t)aGuid;

/**
 批量存入消息
 
 @param messages 要存入的消息组
 
 @return 是否操作成功--忽略值正确性
 */

- (BOOL)insertMessages:(NSDictionary <NSNumber *, LCMessageModel *>*)messages;

/**
 根据会话id和消息id 查询guid

 @param aConversationId 会话id
 @param aMessageId      消息id

 @return 获取的guid
 */
- (int64_t)fetchGuidWithConversationId:(NSString *)aConversationId
                                messageId:(NSString *)aMessageId;


/**
 根据会话id和guid 查询messageId

 @param aConversationId 会话id
 @param guid            服务端消息标识

 @return 获取的消息id
 */
- (NSString *)fetchMessageIdWithConversationId:(NSString *)aConversationId
                                          guid:(int64_t)guid;

/**
 *  获取下页聊天数据
 *
 *  @param count           已经获取的数据条数
 *  @param aNum            下页数据的最大条数
 *  @param aConversationId 会话id
 *
 *  @return 消息数据
 */
- (NSArray<LCMessageModel *> *)fetchNextPageMessagesBaseOnMessageCount:(NSInteger)count messagesNumOnePage:(NSInteger)aNum conversationId:(NSString *)aConversationId;

/**
 获取一条消息

 @param aConversationId 会话id
 @param aMessageId      消息id

 @return 消息数据 
 */
- (LCMessageModel *)fetchMessageWithConversationId:(NSString *)aConversationId
                                         messageId:(NSString *)aMessageId;

/**
 *  删除 Chat 表
 *
 *  @param aConversationId 会话 id
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteChatTableWithConversationId:(NSString *)aConversationId;

/**
 *  删除一条消息
 *
 *  @param aConversationId 消息所在会话的会话id
 *  @param aMessageId      消息的id
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteMessageWithConversationId:(NSString *)aConversationId messageId:(NSString *)aMessageId;


/**
 设置自己的消息为已读

 @param aConversationId 要设置的传话id

 @return 是否操作成功
 */
- (BOOL)setMyMessagesReadInConversationId:(NSString *)aConversationId;

#pragma mark - 会话表

/**
 *  获取所有的会话
 *
 *  @return 会话数组
 */
- (NSArray <LCConversationModel *>*)fetchAllConversations;

/**
 *  删除一条会话
 *
 *  @param aConversationId 要删除会话的id
 *  @param confirm         是否同时删除会话下所有消息（删除对应消息表）
 *
 *  @return 是否操作成功
 */
- (BOOL)deleteConversationWithConversationId:(NSString *)aConversationId deleteMessages:(BOOL)confirm;

/**
 *  未读消息总数
 *
 *  @return 未读消息总数
 */
- (NSInteger)unreadMessagesCount;

#pragma mark - 重发表
/**
 *  插入一条消息到重发表
 *
 *  @param aMessage 要插入的消息
 *
 *  @return 是否操作成功
 */
- (BOOL)insertOrUpdateMessageToResendTable:(LCMessageModel *)aMessage;

/**
 *  获取重发表数据条数
 *
 *  @return 消息条数
 */
- (NSInteger)allResendMessagesNum;

/**
 *  获取所有的重发消息
 *
 *  @return 重发消息数组
 */
- (NSArray <LCResendMessageModel *>*)fetchAllResendMessages;

/**
 *  删除重发消息
 *
 *  @param aMessageId 要删除的重发消息id
 *
 *  @return 是否操作成功
 */
- (BOOL)deleteResendMessageWithMessageId:(NSString *)aMessageId;


/**
 删除一个会话中所有的重发消息

 @param aConversationId 要删除的重发消息对应的会话id

 @return 是否操作成功
 */
- (BOOL)deleteResendMessageWithConversationId:(NSString *)aConversationId;

#pragma mark - 上传表
/**
 *  插入 更新 上传表中的数据
 *
 *  @param aMessage 要更新的消息
 *  @param piece    数据上传了几片
 *  @param uuid     服务端返回的uuid
 *
 *  @return 操作结果
 */
- (BOOL)insertOrUpdateMessageToUploadTable:(LCMessageModel *)aMessage piece:(NSInteger)piece uuid:(NSString *)uuid;

/**
 *  删除上传表中一条数据
 *
 *  @param aMessageId 要删除消息的id
 *
 *  @return 操作结果
 */
- (BOOL)deleteUploadMessageWithMessageId:(NSString *)aMessageId;

/**
 *  查询上传表中是否存在此消息
 *
 *  @param aMessageId 消息id
 *
 *  @return 查询结果
 */
- (BOOL)haveMessageInUploadTableWithMessageId:(NSString *)aMessageId;

/**
 *  获取上传消息
 *
 *  @param aMessageId 消息id
 *  @param handler    结果返回
 */
- (void)fetchUploadMessageWithMessageId:(NSString *)aMessageId handler:(void(^)(LCMessageModel *messageModel, NSInteger piece, NSString *uuid))handler;

#pragma mark - 群组表
/**
 *  插入、更新群组信息
 *
 *  @param aGroupInfo 群组信息
 *
 *  @return 是否操作成功
 */
- (BOOL)insertOrUpdateGroupInfo:(LCGroupInfoModel *)aGroupInfo;

/**
 插入更新群组基本信息

 @param aBaseGroupInfo 群组基本信息

 @return 是否操作成功
 */
- (BOOL)insertOrUpdateBaseGroupInfo:(LCGroupInfoModel *)aBaseGroupInfo;

/**
 更新用户在群内的昵称

 @param aNick    新昵称
 @param aGroupId 要设置的群组的groupId

 @return 是否操作成功
 */
- (BOOL)updateUserInGroupNick:(NSString *)aNick
                      groupId:(NSString *)aGroupId;

/**
 更新本人在群内角色

 @param role     新角色
 @param aGroupId 要设置的群组的groupId

 @return 是否操作成功
 */
- (BOOL)updateSelfRoleInGroup:(LCRole)role
                      groupId:(NSString *)aGroupId;

/**
 更新群组静默状态

 @param silent   是否静默（true：静默， false：不静默）
 @param aGroupId 要设置的群组的groupId

 @return 是否操作成功
 */
- (BOOL)updateGroupSilent:(BOOL)silent
                  groupId:(NSString *)aGroupId;

/**
 *  删除一片群组
 *
 *  @param aGroupId 要删除的群组的groupId
 *  @param confirm  是否要删除对应的群成员表
 *
 *  @return 是否操作成功
 */
- (BOOL)deleteGroupInfoWithGroupId:(NSString *)aGroupId removeAllMembers:(BOOL)confirm;

/**
 *  获取所有的群组信息
 *
 *  @return 群组数组
 */
- (NSArray <LCGroupInfoModel *>*)fetchAllGroupInfo;

/**
 根据 groupId 查询群组信息

 @param aGroupId 要查询的群组的groupId

 @return 群组信息
 */
- (LCGroupInfoModel *)fetchGroupInfoWithGroupId:(NSString *)aGroupId;

#pragma mark - 群成员表

/**
 *  插入、更新一个群成员资料
 *
 *  @param aCrew    群成员
 *  @param aGroupId 所属群id
 *
 *  @return 是否操作成功
 */
- (BOOL)insertOrUpdateGroupMember:(LCCrewDetail *)aCrew toGroup:(NSString *)aGroupId;

/**
 更新群成员昵称

 @param aGroupMember 群成员
 @param aGroupId     所属群id

 @return 是否操作成功
 */
- (BOOL)updateGroupMemberNick:(LCCrewModel *)aGroupMember
                      groupId:(NSString *)aGroupId;

/**
 更新群描述

 @param aGroupDesc 新的群描述
 @param aGroupId   所属群Id

 @return 是否操作成功
 */
- (BOOL)updateGroupDesc:(NSString *)aGroupDesc
                groupId:(NSString *)aGroupId;

/**
 *  删除一个群成员
 *
 *  @param aUserName 要删除的成员用户名
 *  @param aGroupId  从哪个群中移除
 *
 *  @return 是否操作成功
 */
- (BOOL)deleteGroupMemeber:(NSString *)aUserName fromGroup:(NSString *)aGroupId;

/**
 *  获取一个群组下的所有群成员
 *
 *  @param aGroupId 对应的群id
 *
 *  @return 群成员数组
 */
- (NSArray <LCCrewDetail *>*)fetchAllGroupMembersWithGroupId:(NSString *)aGroupId;

/**
 *  成员列表中最新的更新时间
 *
 *  @param aGroupId 对应的群id
 *
 *  @return 更新时间 
 */
- (NSTimeInterval)crewListModifyTimeWithGroupId:(NSString *)aGroupId;

#pragma mark - 好友表


/**
 更新 or 插入好友资料

 @param aFriend 要更新的好友资料

 @return 是否操作成功
 */
- (BOOL)insertOrUpdateFriend:(LCFriendModel *)aFriend;

/**
 更新好友静默状态

 @param silent          是否静默（true：静默， false：不静默）
 @param aFriendUsername 要设置的好友用户名

 @return 是否操作成功
 */
- (BOOL)updateFriendSilent:(BOOL)silent
            friendUsername:(NSString *)aFriendUsername;


/**
 获取所有的好友列表

 @return 好友数组
 */
- (NSArray <LCFriendModel *>*)fetchAllFriends;


/**
 根据用户名查询好友信息

 @param userName 好友用户名

 @return 好友信息
 */
- (LCFriendModel *)fetchFriendWithUserName:(NSString *)userName;


/**
 删除一个好友

 @param aUserName 要删除好友的用户名

 @return 是否操作成功
 */
- (BOOL)deleteFriendWithUserName:(NSString *)aUserName;

#pragma mark - 请求表

/**
 插入更新请求表

 @param username   用户名
 @param requestId  请求id
 @param modifyTime 更新时间

 @return 是否操作成功
 */
- (BOOL)insertOrUpdateRequestWithRequestModel:(LCFriendRequestModel *)requestModel;

/**
 删除请求表数据

 @param username 用户名

 @return 是否操作成功
 */
- (BOOL)deleteRequestWithUsername:(NSString *)username;

/**
 获取请求数据

 @param username 用户名

 @return 请求结果
 */
- (LCFriendRequestModel *)fetchRequestWithUsername:(NSString *)username;


/**
 获取所有请求数据

 @return 请求数据数组
 */
- (NSArray <LCFriendRequestModel *>*)fetchAllRequestMessages;

#pragma mark - 用户表
/**
 插入或更新一个用户

 @param user 用户资料

 @return 是否操作成功
 */
- (BOOL)insertOrUpdateUser:(LCUserInfoShared *)user;

/**
 更新用户的MessageGuid

 @param aMessageGuid 要写入的messageGuid

 @return 操作是否成功
 */
- (BOOL)updateUserMessageGuid:(int64_t)aMessageGuid;

/**
 更新用户的 群组同步时间

 @param modifyTime 要写入的时间

 @return 操作是否成功
 */
- (BOOL)updateUserGroupModifyTime:(NSTimeInterval)modifyTime;

/**
 更新用户 好友同步时间

 @param modifyTime 要写入的时间

 @return 操作是否成功
 */
- (BOOL)updateUserFriendModifyTime:(NSTimeInterval)modifyTime;

/**
 更新用户 上次接收到好友请求时间

 @param modifyTime 要写入的时间

 @return 操作是否成功
 */
- (BOOL)updateUserFriendRequestModifyTime:(NSTimeInterval)modifyTime;

/**
 删除一个用户

 @param aUsername 要删除用户名

 @return 是否操作成功
 */
- (BOOL)deleteUserWithUsername:(NSString *)aUsername;

/**
 查询当前登录用户信息

 @return 用户信息，可能为nil
 */
- (LCUserInfoShared *)fetchCurrentUserInfo;

/**
 查询用户信息

 @param userName 要查询的用户名

 @return 用户信息，可能为nil
 */
/**
 从数据库获取用户信息model
 
 @param userName 用户名
 
 @return 用户信息LCUserInfoModel
 */
- (LCUserInfoModel *)getUserInfoModelWithUserName:(NSString *)userName;

/**
 查询当前登录用户信息
 
 @return 用户信息，可能为nil
 */
- (LCUserInfoModel *)fetchCurrentUserInfoModel;

@end
