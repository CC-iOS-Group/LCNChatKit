//
//  LCNMessageModelProtocol.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/9.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCNMessageModelDelegate <NSObject>

@required

- (NSString *)senderID;

- (NSString *)senderDisplayName;

- (NSString *)receiveID;

- (NSString *)receiveDisplayName;

- (NSDate *)date;

- (BOOL) isMediaMessage;

- (NSUInteger)messageHash;

@optional

@end

