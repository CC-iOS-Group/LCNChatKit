//
//  LCNAudioMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaItem.h"

@interface LCNAudioMediaItem : LCNMediaItem<LCNMediaItemProtocol>

@property (nonatomic, strong, nullable) NSData *audioData;

@property (nonatomic, assign) CGFloat duration;//毫秒为单位

@property (nonatomic, assign) BOOL isReadyToPlay;

@end
