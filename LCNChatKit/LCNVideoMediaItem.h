//
//  LCNVideoMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaItem.h"

@interface LCNVideoMediaItem : LCNMediaItem<LCNMediaItemProtocol>

@property (nonatomic, strong) NSURL *fileUrl;

@property (nonatomic, assign) BOOL isReadyToPlay;

@end
