//
//  LCNImageMediaItem.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNImageMediaItem.h"
#import "LCNMsgBubbleMaskMaker.h"

static CGFloat const kDefaultImageWidth = 150;
static CGFloat const kDefaultImageHeight = 75;

@interface LCNImageMediaItem()


/**
 用于缓存生成过的聊天气泡
 */
@property (nonatomic, strong) UIImageView *cachedImageMediaView;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation LCNImageMediaItem

- (instancetype)initWithImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    self = [super init];
    if (self) {
        _image = image;
        _image_Width = width;
        _image_Height = height;
        
    }
    return self;
}

- (instancetype)initWithImageUrl:(NSString *)imageUrl width:(CGFloat)width height:(CGFloat)height{
    self = [super init];
    if (self) {
        _imageUrl = imageUrl;
        _image_Width = width;
        _image_Height = height;
    }
    return self;
}

#pragma mark - LCNMediaItemProtocol
-(UIView *)mediaView{
    
    if (_image == nil && _imageUrl == nil) {
        return  nil;
    }
    
    //检查图片宽高，若不合适设置为默认宽高
    if (_image_Width == 0 || _image_Height == 0) {
        _image_Width = kDefaultImageWidth;
        _image_Height = kDefaultImageHeight;
    }
    
    if (self.cachedImageMediaView == nil) {
    
        //创建气泡视图
        UIImageView *imageView = [UIImageView new];
        imageView.size = CGSizeMake(_image_Width, _image_Height);//size 需要提前获取
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.mask = [LCNMsgBubbleMaskMaker bubbleLayerWith:imageView.bounds isOutgoing:self.isOutgoing];

        if (_image) {
            [imageView setImage:_image];
        }
        else if(_imageUrl){
            NSURL *imageUrl = [NSURL URLWithString:_imageUrl];
            [_indicatorView startAnimating];
            @weakify(self);
            [imageView setImageWithURL:imageUrl placeholder:nil //默认图片
                               options:YYWebImageOptionProgressiveBlur progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
                //制作接受进度指示
                
            } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                return nil;
            } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                weak_self.image = image;
                [weak_self.indicatorView stopAnimating];

            }];
        }
        else{
            [imageView setImage:nil];//默认图片
        }
        
        //将气泡视图缓存在数据源中
        self.cachedImageMediaView = imageView;
    }
    
    return self.cachedImageMediaView;
}

-(CGSize)mediaViewDisplaySize{
    return CGSizeMake(_image_Width, _image_Height);
}


#pragma mark - Setter & Getter 
-(UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

@end
