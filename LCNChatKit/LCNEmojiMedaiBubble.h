//
//  LCNEmojiMedaiItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaBubble.h"
@class YYImage;

@interface LCNEmojiMedaiBubble : LCNMediaBubble<LCNMediaBubbleDelegate>

@property (nonatomic, strong) YYImage *animatedImage;
@property (nonatomic, strong) NSString *animatedImageUrl;
@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, strong) YYAnimatedImageView *imageView;



- (instancetype)initWithEmojiImage:(YYImage *)image size:(CGSize)size;

- (instancetype)initWithEmojiImageUrl:(NSString *)imageUrl size:(CGSize)size;

@end
