//
//  LittleCIM.h
//  LittleCIM
//
//  Created by zhaojunjie on 16/7/14.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for LittleCIM.
FOUNDATION_EXPORT double LittleCIMVersionNumber;

//! Project version string for LittleCIM.
FOUNDATION_EXPORT const unsigned char LittleCIMVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <LittleCIM/PublicHeader.h>

#pragma mark - Manager

#import <LittleCIM/LCOptions.h>
#import <LittleCIM/LCClient.h>
#import <LittleCIM/LCChatManager.h>
#import <LittleCIM/LCGroupManager.h>
#import <LittleCIM/LCContactManager.h>
#import <LittleCIM/LCPushManager.h>
#import <LittleCIM/LCDBManager.h>
#import <LittleCIM/LCHistoryManager.h>

#pragma mark - Model

#import <LittleCIM/LCMessageModel.h>
#import <LittleCIM/LCMessageBodyModel.h>
#import <LittleCIM/LCTextMessageBodyModel.h>
#import <LittleCIM/LCFileMessageBodyModel.h>
#import <LittleCIM/LCImageMessageBodyModel.h>
#import <LittleCIM/LCVoiceMessageBodyModel.h>
#import <LittleCIM/LCVideoMessageBodyModel.h>
#import <LittleCIM/LCLocationMessageBodyModel.h>
#import <LittleCIM/LCAtMessageBodyModel.h>
#import <LittleCIM/LCReadReceiptMessageBodyModel.h>
#import <LittleCIM/LCRetractMessageBodyModel.h>
#import <LittleCIM/LCCustomMessageBodyModel.h>
#import <LittleCIM/LCGroupSignalMessageBodyModel.h>
#import <LittleCIM/LCError.h>
#import <LittleCIM/LCGroupInfoModel.h>
#import <LittleCIM/LCCrewModel.h>
#import <LittleCIM/LCConversationModel.h>
#import <LittleCIM/LCFriendModel.h>
#import <LittleCIM/LCUserInfoModel.h>

#pragma mark - Tool
#import <LittleCIM/LCCommonEnum.h>


#import <LittleCIM/LCGroupManagerDelegate.h>



