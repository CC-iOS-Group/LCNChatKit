//
//  LCNTextMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/21.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaBubble.h"

@interface LCNTextMediaItem : LCNMediaBubble <LCNMediaBubbleProtocol>

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) YYTextLayout *layout;

- (instancetype)initWithContent:(NSString *)content;

@end
