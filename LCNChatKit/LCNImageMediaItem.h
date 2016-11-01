//
//  LCNImageMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaItem.h"

@interface LCNImageMediaItem : LCNMediaItem<LCNMediaItemProtocol>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, assign) CGFloat image_Width;
@property (nonatomic, assign) CGFloat image_Height;

- (instancetype)initWithImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height;

- (instancetype)initWithImageUrl:(NSString *)imageUrl width:(CGFloat)width height:(CGFloat)height;

@end