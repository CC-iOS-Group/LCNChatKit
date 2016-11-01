//
//  LCNTextMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/21.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaItem.h"

@interface LCNTextMediaItem : LCNMediaItem <LCNMediaItemProtocol>

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) YYTextLayout *layout;

- (instancetype)initWithContent:(NSString *)content;

@end
