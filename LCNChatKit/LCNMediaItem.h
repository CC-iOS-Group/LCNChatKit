//
//  LCNMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCNMediaItemProtocol.h"

typedef NS_ENUM(NSUInteger, LCNMediaType) {
    LCNMediaType_Text,
    LCNMediaType_Image,
    LCNMediaType_Emoji,
    LCNMediaType_Audio,
    LCNMediaType_Video,
    LCNMediaType_Contact,
    LCNMediaType_Location,
    LCNMediaType_Share
};

@interface LCNMediaItem : NSObject <LCNMediaItemProtocol>

@property (nonatomic, assign) BOOL isOutgoing;

@property (nonatomic, strong) UIView *mediaView;

@property (nonatomic, assign) CGSize mediaViewDisplaySize;

@end