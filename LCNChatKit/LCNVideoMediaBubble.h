//
//  LCNVideoMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaBubble.h"

@interface LCNVideoMediaBubble : LCNMediaBubble<LCNMediaBubbleDelegate>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSData *videoData;

@property (nonatomic, strong) NSString *fileUrl;

- (instancetype)initWithVideoData:(NSData *)videoData image:(UIImage *)image;

- (instancetype)initWithFileUrl:(NSString *)fileUrl image:(UIImage *)image;

@end
