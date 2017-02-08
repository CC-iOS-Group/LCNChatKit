//
//  LCNCollectionViewOutgoingCell.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNCollectionViewOutgoingCell.h"

@implementation LCNCollectionViewOutgoingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        

        
    }
    return self;
}

#pragma mark - Cell 生命周期
-(void)prepareForReuse{
}

#pragma mark - 布局Cell
-(void)setLayout:(LCNMessageLayout *)layout{
    
    //公共属性设置放在父类中实现,用于填充视图内容
    [super setLayout:layout];
    
    
    //布局Cell内视图
    [self.timeLabel sizeToFit];
    self.timeLabel.width += 2*kCellSmallGap;
    self.timeLabel.top = 0;
    self.timeLabel.left = (kScreenWidth - self.timeLabel.width)/2;
    
    self.avatarImageView.size = CGSizeMake(kAvatarImageView_WH, kAvatarImageView_WH);
    
    self.nameLabel.size = CGSizeMake(kMediaContainerrView_Max_W, kNameLable_H);
    
    self.mediaContainerrView.size = CGSizeMake(layout.mediaViewSize.width, layout.mediaViewSize.height);
    
    
    if (layout.isShowTimeLabel) {
        self.timeLabel.hidden = NO;
        self.avatarImageView.top = kTimeLabel_H;
        self.nameLabel.top = kTimeLabel_H;
//        self.mediaContainerrView.left = kScreenWidth-kCellMiddleGap-kAvatarImageView_WH-kCellSmallGap-layout.model.mediaBubble.mediaViewDisplaySize.width;
        self.mediaContainerrView.top = kTimeLabel_H + kNameLable_H;
    }
    else{
        self.timeLabel.hidden = YES;
        self.avatarImageView.top = 0;
        self.nameLabel.top = 0;
        self.mediaContainerrView.top = kNameLable_H;
    }
    
    self.avatarImageView.left = kScreenWidth-kCellMiddleGap-kAvatarImageView_WH;
    self.nameLabel.left = kScreenWidth-kCellMiddleGap-kAvatarImageView_WH-kCellMiddleGap-self.nameLabel.width;
    self.mediaContainerrView.left = kScreenWidth-kCellMiddleGap-kAvatarImageView_WH-kCellSmallGap-layout.mediaViewSize.width;


    
    if (layout.isShowStatusLabel) {
        self.statusLabel.hidden = NO;
        self.statusLabel.size = CGSizeMake(kScreenWidth, kStatusLabel_H);
        self.statusLabel.left = 0;
        self.statusLabel.top = self.mediaContainerrView.top + self.mediaContainerrView.height;
    }
    else{
        self.statusLabel.hidden = YES;
    }
}

@end
