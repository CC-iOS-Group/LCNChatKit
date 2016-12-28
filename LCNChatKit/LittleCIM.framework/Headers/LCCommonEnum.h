//
//  LCCommonEnum.h
//  LittleCIM
//
//  Created by shenhongbang on 16/8/10.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

// 控制台打印级数
typedef NS_ENUM(NSInteger, LCLogLevel) {
    LCLogLevelAll       = 1,        //在控制台输出SDK所有日志
    LCLogLevelInfo      = 1 << 1,   //在控制台输出SDK信息日志
    LCLogLevelWarning   = 1 << 2,   //在控制台只输出SDK警告日志
    LCLogLevelError     = 1 << 3,   //在控制台只输出SDK错误日志
    LCLogLevelNone      = 1 << 4,   //在控制台不输出任何日志
};

typedef NS_ENUM(NSInteger, LCChatType)
{
    /**
     *  单聊
     */
    LCChatTypeSingle = 0,
    /**
     *  群聊
     */
    LCChatTypeGroup = 1,
    /**
     *  群发消息
     */
    LCChatTypeMultiMsg = 5,
    /**
     *  未知类型
     */
    LCChatTypeUnkonw,
};

/**
 *  网络连接状态
 */
typedef NS_ENUM(NSInteger, LCConnectionStatus) {
    /**
     *  已连接
     */
    LCConnectionStatusConnected    = 0,
    /**
     *  未连接（包括无网络和假连接状态）
     */
    LCConnectionStatusDisconnected = 1,
    /**
     *  未知状态
     */
    LCConnectionStatusUnkonw,
};

/**
 *  消息状态
 */
typedef NS_ENUM(NSInteger, LCChatStatus) {
    /**
     *  发送中
     */
    LCChatStatusSending = 0,
    /**
     *  发送成功
     */
    LCChatStatusSendSuccess = 1,
    /**
     *  发送失败
     */
    LCChatStatusSendFail = 2,
    /**
     *  已读 （用于标记在自己发送的单聊消息上）
     */
    LCChatStatusRead = 3,
    /**
     *  未读 （用于标记在自己发送的单聊消息上）
     */
    LCChatStatusUnread = 4,
    /**
     *  未知状态
     */
    LCChatStatusUnkonw,
};

typedef NS_ENUM(NSInteger, LCMessageBodyType)
{
    /**
     *  文本消息类型
     */
    LCMessageBodyTypeText    = 0,
    /**
     *  标准图片消息类型
     */
    LCMessageBodyTypeImage   = 1,
    /**
     *  视频消息类型
     */
    LCMessageBodyTypeVideo   = 2,
    /**
     *  声音消息类型
     */
    LCMessageBodyTypeVoice   = 3,
    /**
     *  位置消息类型
     */
    LCMessageBodyTypeLocation = 4,
    /**
     *  At消息类型
     */
    LCMessageBodyTypeAt       = 5,
    /**
     *  回执消息类型
     */
    LCMessageBodyTypeReceipt  = 6,
    /**
     *  普通文件格式的消息类型
     */
    LCMessageBodyTypeFile     = 7,
    /**
     *  撤回消息类型
     */
    LCMessageBodyTypeRetract  = 8,
    /**
     *  自定义消息类型
     */
    LCMessageBodyTypeCustom   = 9,
    /**
     *  群信令消息
     */
    LCMessageBodyTypeGroupSignal = 10,
    /**
     *  名片消息类型
     */
    LCMessageBodyTypeVCard,
    /**
     *  表情商店消息类型
     */
    LCMessageBodyTypeVemotion,
    /**
     *  短信格式的消息类型
     */
    LCMessageBodyTypeSMS,
    /**
     *  好友请求的消息类型
     */
    LCMessageBodyTypeFriendRequest,
    /**
     *  未知
     */
    LCMessageBodyTypeUnkonw,
};

/**
 *  角色
 */
typedef NS_ENUM(NSInteger, LCRole) {
    /**
     *  群主
     */
    LCRole_Owner = 0,
    /**
     *  管理员
     */
    LCRole_Admin,
    /**
     *  普通成员
     */
    LCRole_Member,
};


typedef NS_ENUM(NSInteger, LCGroupSignalType)
{
    /**
     *  建群信令
     */
    LCSignalTypeGroupCreated = 0,
    /**
     *  邀请入群信令
     */
    LCSignalTypeInviting= 1,
    /**
     *  同意入群邀请信令
     */
    LCSignalTypeInvitationAccepted = 2,
    /**
     *  受邀者入群信令
     */
    LCSignalTypeInviteeJoinGroup = 3,
    /**
     *  拒绝入群邀请信令
     */
    LCSignalTypeInvitationDeclined = 4,
    /**
     *  加入群聊信令, 和INVITEE_JOIN_GROUP_SIGNAL的区别：直接拉入群触发的信令
     */
    LCSignalTypeJoinGroup = 5,
    /**
     *  成员被踢出信令
     */
    LCSignalTypeBeKicked = 6,
    /**
     *  成员退群信令
     */
    LCSignalTypeExited = 7,
    /**
     *  群被解散信令
     */
    LCSignalTypeGroupDestroyed = 8,
    /**
     *  群主变更信令
     */
    LCSignalTypeOwnerChanged = 9,
    /**
     *  群名称变更信令
     */
    LCSignalTypeGroupNameChanged = 10,
    /**
     *  成员昵称变更信令
     */
    LCSignalTypeNickChanged = 11,
    /**
    *  新管理员信令
    */
    LCSignalTypeBeAdmin = 12,
    /**
     *  申请入群信令（发送给群主和管理员）
     */
    LCSignalTypeApplyJoin = 13,
    /**
     *  被同意入群信令，发送给所有群成员
     */
    LCSignalTypeBeApprovedJoin = 14,
    /**
     *  被拒绝入群信令，发送给申请入群者
     */
    LCSignalTypeBeRefuseJoin = 15,
};

typedef NS_ENUM(NSInteger, LCRequestStatus){
    /**
     * 未处理
     */
    LCRequestStatus_Untreated = 0,
    /**
     * 已接受
     */
    LCRequestStatus_BeenAccepted,
    /**
     * 已拒绝
     */
    LCRequestStatus_BeenRefused,
};

