//
//  LCNMessageModel.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCNMediaBubble.h"

#import "LCNMessageModelDelegate.h"
#import "LCNMediaBubbleDelegate.h"

@interface LCNMessageModel : NSObject <LCNMessageModelDelegate>

@property (nonatomic, assign) BOOL isOutgoing; //是否是发出的消息

@property (nonatomic, strong) NSString *messageID;

@property (nonatomic, strong) NSString *senderID;

@property (nonatomic, strong) NSString *senderDisplayName;

@property (nonatomic, strong) NSString *senderAvatarImageUrl;

@property (nonatomic, strong) NSString *receiveID;

@property (nonatomic, strong) NSString *receiveDisplayName;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) LCNMediaType mediaType;

@property (nonatomic, strong) id<LCNMediaBubbleDelegate> mediaBubble;

@property (nonatomic, assign) NSUInteger messageHash;

@end
