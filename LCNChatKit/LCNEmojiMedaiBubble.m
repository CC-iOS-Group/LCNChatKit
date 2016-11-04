
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
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

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

- (instancetype)initWithEmojiImageUrl:(NSString *)imageUrl size:(CGSize)size{
    self = [super init];
    if (self) {
        _animatedImageUrl = imageUrl;
        _imageSize = size;
    }
    return self;
}

-(UIView *)mediaView{
    if (!_cachedEmojiMediaView) {
    
        if (_imageSize.width <= 0 || _imageSize.height <= 0) {
            _imageSize = CGSizeMake(kDefaultEmoji_Width, kDefaultEmoji_Height);
        }
        
        //创建表情容器
        _imageView = [[YYAnimatedImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.autoPlayAnimatedImage = YES;
        _imageView.size = _imageSize;
        
        [_imageView addSubview:self.indicatorView];
        _indicatorView.center = _imageView.center;
        
        
        //填充内容
        if (_animatedImage != nil) {
            [_imageView setImage:_animatedImage];
        }
        else if(_animatedImageUrl != nil){
            NSURL *url = [NSURL URLWithString:_animatedImageUrl];
            _indicatorView.hidden = NO;
            
            @weakify(self);
            [_indicatorView startAnimating];
            
            [_imageView setImageWithURL:url
                            placeholder:nil
                                options:YYWebImageOptionProgressiveBlur|YYWebImageOptionShowNetworkActivity| YYWebImageOptionSetImageWithFadeAnimation
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   
                               }
                              transform:nil
                             completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                 
                                 weak_self.indicatorView.hidden = YES;
                                 [weak_self.indicatorView stopAnimating];
                             }];
            
        }
        
        
//        [_imageView addObserver:self forKeyPath:@"currentIsPlayingAnimation" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        _cachedEmojiMediaView = _imageView;
    }
    
    return _cachedEmojiMediaView;
}

-(CGSize)mediaViewDisplaySize{
    return _imageSize;
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"currentIsPlayingAnimation"]) {
//        if (_imageView.currentIsPlayingAnimation == NO) {
//            NSLog(@"remove _cachedTmojiMediaView");
//            [_cachedEmojiMediaView removeObserver:self forKeyPath:@"currentIsPlayingAnimation"];
//            _cachedEmojiMediaView = nil;
//        }
//    }
//}

#pragma mark - Setter & Getter
-(UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.size = CGSizeMake(10, 10);
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

@end
