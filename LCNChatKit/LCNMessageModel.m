//
//  LCNMessageModel.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNMessageModel.h"
#import "LCNAudioRecordingMediaBubble.h"

@implementation LCNMessageModel

+ (LCNMessageModel *)getRecordingMessageModel{
    LCNMessageModel *messageModel = [LCNMessageModel new];
    messageModel.isOutgoing = YES;
    messageModel.senderID = nil;
    messageModel.senderDisplayName = @"XXXX";
    messageModel.senderAvatarImageUrl = @"https://img3.doubanio.com/icon/ul21552107-31.jpg";
    messageModel.date = [NSDate date];
    messageModel.mediaBubble = [LCNAudioRecordingMediaBubble new];
    
    return messageModel;
}

@end
