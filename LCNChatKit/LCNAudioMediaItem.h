//
//  LCNAudioMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaItem.h"

@interface LCNAudioMediaItem : LCNMediaItem<LCNMediaItemProtocol>

@property (nonatomic, strong) NSString *downloadLink;

@property (nonatomic, strong) NSData *audioData;

@property (nonatomic, assign) CGFloat duration;//毫秒为单位


- (instancetype)initWithNSData:(NSData *)audioData duration:(CGFloat)duration;

- (instancetype)initWithDownloadLink:(NSString *)link duration:(CGFloat)duration;

- (void)startPlayAudio;

- (void)stopPlayAudio;


@end
