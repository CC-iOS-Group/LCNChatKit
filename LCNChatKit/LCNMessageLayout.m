//
//  LCNMessageLayout.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNMessageLayout.h"
#import "LCNCollectionViewCell.h"

@implementation LCNMessageLayout

-(LCNMessageLayout *)initWithLCNMessageModel:(LCNMessageModel *)currentModel preMessageModel:(LCNMessageModel *)preModel{
    self = [super init];
    if (self) {
        
        _model = currentModel;
        
        _isShowStatusLabel = YES;
        
        //判断是否需要显示时间Label
        _isShowTimeLabel = ([currentModel.date timeIntervalSinceDate:preModel.date] > 60) || preModel == nil;
        
        
        //气泡区域高度
        _mediaViewSize = currentModel.mediaBubble.mediaViewDisplaySize;

        //cell高度 = 时间戳高度 + 气泡区域高度 + 消息状态区高度
        _cellHeight = (_isShowTimeLabel?kTimeLabel_H:0) + (((kNameLable_H + _mediaViewSize.height)>kAvatarImageView_WH) ?(kNameLable_H + _mediaViewSize.height):kAvatarImageView_WH) +  (_isShowStatusLabel?kStatusLabel_H:0);
    }
    
    return self;
}

@end
