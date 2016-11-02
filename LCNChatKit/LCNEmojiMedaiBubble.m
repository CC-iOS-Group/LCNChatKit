
//
//  LCNEmojiMedaiItem.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNEmojiMedaiBubble.h"

#define kDefaultEmoji_Width 100
#define kDefaultEmoji_Height 60

@interface LCNEmojiMedaiBubble()

@property (nonatomic, strong) UIView *cachedEmojiMediaView;

@end

@implementation LCNEmojiMedaiBubble

- (instancetype)initWithEmojiImage:(YYImage *)image size:(CGSize)size{
    self = [super init];
    if (self) {
        
        _animatedImage = image;
        _imageSize = size;
        
    }
    return self;
}

-(UIView *)mediaView{
    if (!_cachedEmojiMediaView) {
        
        if (_imageSize.width <= 0 || _imageSize.height <= 0) {
            _imageSize = CGSizeMake(kDefaultEmoji_Width, kDefaultEmoji_Height);
        }
        
        _imageView = [[YYAnimatedImageView alloc] initWithImage:_animatedImage];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.size = _imageSize;
        
        _cachedEmojiMediaView = _imageView;
    }
    
    return _cachedEmojiMediaView;
}

-(CGSize)mediaViewDisplaySize{
    return _imageSize;
}

@end
