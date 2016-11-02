//
//  LCNEmojiMedaiItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaBubble.h"
@class YYImage;

@interface LCNEmojiMedaiItem : LCNMediaBubble<LCNMediaBubbleProtocol>

@property (nonatomic, strong) YYImage *animatedImage;

@end
