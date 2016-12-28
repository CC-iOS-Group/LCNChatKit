//
//  LCError.h
//  LittleCIM
//  @abstract 错误信息
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LCErrorCode)
{
    /*平台侧错误码*/
    LCErrorCode_DatabaseError = 1,                 // server端数据库异常
    LCErrorCode_SessionTimeouted,                  // token过期
    LCErrorCode_UserNameOrPasswordError,           // 用户名或密码错误
    LCErrorCode_SystemError,                       // 系统错误
    LCErrorCode_AccessResourceFailed,              // 资源访问失败
    LCErrorCode_PermissionDenied,                  // 该操作用户没有权限
    LCErrorCode_ParamInvalid,                      // 请求包含错误参数
    LCErrorCode_ProtoParseError = 8,               // PB解析出错
    
    LCErrorCode_UserLoginedOtherDevice = 20,       // 账号在其他地方登陆
    LCErrorCode_UserTempProhibit,                  // 系统临时禁止登陆
    LCErrorCode_AppkeyOrAppkeyPasswordError = 23,  // appkey或者appkeyPassword不存在
    
    LCErrorCode_ServerInnerError = 500,            // 服务器内部错误
    LCErrorCode_UserNotExisted,                    // 用户不存在
    LCErrorCode_UserAlreadyRegistered,             // 用户已注册
    LCErrorCode_PhoneInvalid = 503,                // 手机号不合法
    
    LCErrorCode_UserNotLogin = 601,                // 用户未登陆
    LCErrorCode_UserConflictLogin,                 // 其他用户登陆，被踢
    LCErrorCode_SessionStatusError = 603,          // session连接异常
    
    LCErrorCode_ChatSenderIsForbidden = 1001,      // 发送方被禁言
    LCErrorCode_ChatReceiverNotExist,              // 接收方不存在
    LCErrorCode_ChatMessageInvalid,                // 消息内容不正确
    LCErrorCode_ChatMessageSaveFailed = 1004,      // 消息存储失败
    LCErrorCode_ChatSomeReceiverNotExist = 1007,   // 群发部分接收者不存在
    
    LCErrorCode_PushUidNullError = 1201,           // 用户ID为空
    LCErrorCode_PushCreateCrtificateFailed = 1202, // 创建证书失败
    LCErrorCode_PushDeleteCrtificateFailed,        // 删除证书失败
    LCErrorCode_PushClearTokenFailed,              // 清除token失败
    LCErrorCode_PushSetTokenFailed,                // 设置token失败
    LCErrorCode_PushQueryCrtTypeFailed = 1206,     // 查询crt type失败
    LCErrorCode_PushSetBadgeFailed = 1207,         // 设置badge失败
    
    LCErrorCode_GroupExceedCrewCountLimit = 1401,  // 超出群人数限制
    LCErrorCode_GroupOwnerMustNotBeEmpty,          // 群主不能为空
    LCErrorCode_GroupNameExceedLimit = 1403,       // 群名称超过长度限制
    LCErrorCode_GroupNotExist,                     // 群不存在或已失效
    LCErrorCode_GroupInviteeAlreadyIn,             // 受邀者已在群中
    LCErrorCode_GroupInvitationUnavailable,        // 邀请无效或已过期
    LCErrorCode_GroupRequesterNotInGroup,          // 请求者不在群中
    LCErrorCode_GroupEmptyMemberAndInvitee,        // 成员及受邀请者列表为空
    LCErrorCode_GroupRequesterIsNotOwner,          // 请求者不是群主
    LCErrorCode_GroupRequesterAlreadyIn = 1410,    // 请求者已在群中
    LCErrorCode_GroupCrewNickExceedLimit,          // 群成员昵称超过长度限制
    LCErrorCode_GroupReasonLengthLimit,            // 请求原因超出长度限制
    LCErrorCode_GroupJoinGroupHasBeenProcessed,    // 入群申请已经被处理
    LCErrorCode_GroupNeverJoinGroup,               // 被处理入群申请者从未申请入群
    LCErrorCode_GroupRequesterIsNotOwnerOrAdmin=1415,// 请求者非群主或群管理员
    LCErrorCode_GroupNewOwnerNotInGroup,           // 转移群主：被转移者不在群中
    LCErrorCode_GroupAdminsInvalid,                // 指定的管理员无效（不在群中或已经是管理员）
    LCErrorCode_GroupParamError,                   // 请求参数出错
    LCErrorCode_GroupEmptyBekickedList,            // 被踢者列表为空
    LCErrorCode_GroupMemberDoKickForbidden = 1420, // 群成员角色禁止踢人
    LCErrorCode_GroupSelfKickForbidden,            // 禁止踢自己出群
    LCErrorCode_GroupAdminKickNonmemberForbdden,   // 管理员禁止踢非普通成员出群
    LCErrorCode_GroupChangeNickListEmpty = 1423,   // 修改昵称列表为空
    LCErrorCode_GroupChangeNickHasError = 1424,    // 修改成员昵称出错
    
    LCErrorCode_HmsMessageStoreError = 2001,       // 消息存储失败
    LCErrorCode_HmsErrorParsingProtoclass,         // 参数解析异常
    LCErrorCode_HmsNoMessageFound,                 // 没有满足查询条件的消息
    LCErrorCode_HmsParamFormatError,               // 参数格式错误
    LCErrorCode_HmsUnkownQueryError = 2005,        // 查询时出现未知错误
    LCErrorCode_HmsGuidInvalidError,               // 查询guid不合法
    
    LCErrorCode_MsggwMessageStoreFailed = 2201,    // 消息网关消息保存失败
    LCErrorCode_WatcherZKNodeNotFound = 2401,      // 未查询到ZK中的node
    
    LCErrorCode_SMSSendFailed = 2601,              // 短信发送失败
    LCErrorCode_EmailSendFailed = 2801,            // 邮件发送失败
    
    LCErrorCode_FrontAppkeyNotFound = 3001,        // appkey不存在
    LCErrorCode_FrontAppkeyAlreadyExists,          // 新增appkey已存在
    LCErrorCode_FrontConsoleAppkeyNotExists,       // console中appkey不存在
    LCErrorCode_FrontSecurityKeyNotMatch = 3004,   // securityKey错误
    
    LCErrorCode_AgentUserCreateHasError = 3101,    // 创建用户失败
    LCErrorCode_AgentUserDeleteHasError,           // 删除用户失败
    LCErrorCode_AgentUserModifyHasError,           // 修改用户失败
    LCErrorCode_AgentUserQueryHasError,            // 查询用户失败
    LCErrorCode_AgentUserSearchHasError,           // 搜索用户失败
    LCErrorCode_AgentCreateGroupError = 3106,      // 创建群失败
    
    LCErrorCode_MonitorAlreadyOpen = 3201,         // 监控已打开
    LCErrorCode_MonitorAlreadyClosed,              // 监控已关闭
    LCErrorCode_MonitorFileUploadError,            // 文件上传错误
    LCErrorCode_MonitorCloseFail,                  // 关闭监控失败
    LCErrorCode_MonitorOpenFail = 3205,            // 开启监控失败
    
    LCErrorCode_FriendQueryFromNickFailed = 3401,  // 用户中心查询好友请求者昵称失败
    LCErrorCode_FriendParameterEmptyError,         // 好友参数为空
    LCErrorCode_FriendRequestNotExit,              // 好友请求不存在
    LCErrorCode_FriendRequestHasBeenProcessed,     // 好友请求已被处理
    LCErrorCode_FriendRequestReceiverNotMatch,     // 同意／拒绝好友请求发起者与好友请求的接收者不匹配
    LCErrorCode_FriendAppkeyNotMatch = 3406,       // appkey不匹配
    
    
    /*终端侧错误码，50000开始*/
    LCErrorCode_RequiredParmIsNil = 50000,         // 必填参数不能为nil
    LCErrorCode_RequiredParmIsIllegal,             // 必填参数不合法
    LCErrorCode_UserNameIsIllegal,                 // 用户名不合法
    LCErrorCode_UserNameIsNil,                     // 用户名不能为nil
    LCErrorCode_PhoneIsIllegal,                    // 手机号不合法
    LCErrorCode_PhoneIsNil,                        // 手机号不能为nil
    LCErrorCode_CaptchaIsIllegal,                  // 验证码不合法
    LCErrorCode_CaptchaIsNil,                      // 验证码不能为nil
    LCErrorCode_PasswordIsIllegal,                 // 密码不合法
    LCErrorCode_PasswordIsNil,                     // 密码不能为nil
    LCErrorCode_UserNickIsIllegal = 50010,        // 昵称不合法
    LCErrorCode_UserNickIsNil,                     // 昵称不能为nil
    LCErrorCode_TextContentIsNil,                  // 文本内容不能为nil
    LCErrorCode_TextContentIsNULL,                 // 文本内容为空
    LCErrorCode_FileNotExist,                      // 文件不存在
    LCErrorCode_FileTypeNotMatch,                  // 文件类型不匹配
    LCErrorCode_FileSizeNotMatch,                  // 文件大小不匹配
    LCErrorCode_FileContentException,              // 文件内容异常
    LCErrorCode_FilePathIsNil,                     // 文件路径不能为nil
    LCErrorCode_FilePathIsIllegal,                 // 文件路径不合法
    LCErrorCode_VoiceDurationIsIllegal = 50020,    // 语音长度不合法
    LCErrorCode_VideoDurationIsIllegal,            // 视频长度不合法
    LCErrorCode_LocationLatitudeException,         // 位置纬度异常
    LCErrorCode_LocationLongitudeException,        // 位置经度异常
    LCErrorCode_MessageBodyIsNil,                  // 消息体不能为nil
    LCErrorCode_MessageBodyIsIllegal,              // 消息体类型不合法
    
    LCErrorCode_DeviceTokenIsNil,                  // 设备token不能为nil
    LCErrorCode_AppkeyIsNil,                       // appkey不能为nil
    LCErrorCode_AppkeyIsIllegal,                   // appkey不合法
    LCErrorCode_AppkeyPasswordIsNil,               // appkeyPassword不能为nil
    LCErrorCode_AppkeyPasswordIsIllegal = 50030,   // appkeyPassword不合法
    LCErrorCode_UploadFileFail,                    // 上传文件失败
    LCErrorCode_SendingMessagesNotContainThisMessage, // 正在发送的消息中不包含此消息
    
    LCErrorCode_GroupIdIsNil,                      // 群id不能为nil
    LCErrorCode_GroupIdIsIllegal,                  // 群id不合法
    LCErrorCode_GroupNameIsNil,                    // 群名称不能为nil
    LCErrorCode_GroupNameIsIllegal,                // 群名称不合法
    LCErrorCode_GroupNickNameIsNil,                // 群昵称不能为nil
    LCErrorCode_GroupNickNameIsIllegal,            // 群昵称不合法
    LCErrorCode_KickSelfForbidden,                 // 踢人不能踢自己
    LCErrorCode_HandoverOwnerToSelfForbidden = 50040, // 群主不能转让给自己
    LCErrorCode_ReasonIsIllegal,                   // 邀请理由或申请入群理由内容不合法
    LCErrorCode_MembersArrayCountIsZero,           // 成员数组中成员个数不能为零（除当前用户）
    LCErrorCode_MembersAndInviteesArrayHaveSameUserName,// 拉人成员数组和邀请成员数组中有相同的用户
    LCErrorCode_GroupDescriptionIsIllegal,         // 群描述不合法
    LCErrorCode_UserNameInMembersArrayIsIllegal,   // 成员数组中成员用户名不合法
    LCErrorCode_MembersArrayCannotContainSelf,     // 成员数组中不能包含自己
    
    LCErrorCode_MessageIdIsNil,                    // messageId不能为nil
    LCErrorCode_MessageIdIsIllegal,                // messageId不合法
    LCErrorCode_ChatTypeError,                     // 聊天类型参数错误 （如：撤回/已读回执消息为单聊消息，发送时参数填群聊）

    LCErrorCode_ForwardMsgNotExist = 50050,        // 需转发的消息不存在
    LCErrorCode_ReadReceiptMsgNotExist,            // 回执对应的消息不存在
    LCErrorCode_RetractMsgNotExist,                // 被撤回的消息不存在
    LCErrorCode_NoPermissions,                     // 无权限操作（如：1.发送撤回/已读回执消息给别的用户；2.要撤回的消息不是自己发送的 3.已读消息非发送方发的）
    
    LCErrorCode_AtMessageMustUseInGroup,           // 群聊@消息对应聊天类型必须是群聊
    
    LCErrorCode_NotAudioFile,                      // 该文件不是音频文件
    LCErrorCode_CannotAddSelfAsFriend,             // 不能添加自己为好友
    LCErrorCode_FriendRequestIdIsNil,              // 好友请求id不能为nil
    LCErrorCode_CannotRemoveSelfInFriends,         // 删除好友不能删除自己
    LCErrorCode_FriendDisplayNameIsIllegal,        // 好友备注名不合法
    
    LCErrorCode_LimitError = 50060,                // 单次请求条数不能小于1
    LCErrorCode_SearchKeyIsNil,                    // 搜索关键字不能为nil
    LCErrorCode_SearchKeyIsIllegal,                // 搜索关键字不合法
    
    
    // 网络
    LCErrorCode_noNet,                             // 没网
    LCErrorCode_ConnectServerFail,                 // 连接服务器失败
    
    //消息重发
    LCErrorCode_ResendFail,                        // 重发失败
    
    // 文件服务器
    LCErrorCode_UploadFileSessionTimeout,          // 文件服务器session超时
    LCErrorCode_getConfigFail,                     // 获取配置信息失败
    
    LCErrorCode_Unknow,                            // 未知错误
};



@interface LCError : NSObject

/**
 *  错误码
 */
@property (nonatomic, assign, readonly) LCErrorCode errorCode;

/**
 *  错误描述
 */
@property (nonatomic, copy, readonly) NSString *errorDescription;

/**
 *  创建错误实例
 *
 *  @param description 错误描述
 *  @param code        错误码
 *
 *  @return 错误对象实例
 */
+ (instancetype)errorWithDescription:(NSString *)description
                                code:(LCErrorCode)code;

/**
 *  创建错误实例
 *
 *  @param aCode 错误码
 *
 *  @return 错误对象实例
 */
+ (LCError *)errorWithCode:(LCErrorCode)code;

@end
