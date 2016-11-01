//
//  LCNCollectionViewIncomingcell.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNCollectionViewIncomingCell.h"

@implementation LCNCollectionViewIncomingCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void)setLayout:(LCNMessageLayout *)layout{
    
    //公共属性设置放在父类中实现,用于填充视图内容
    [super setLayout:layout];
    
    
    //布局Cell内视图
    [self.timeLabel sizeToFit];
    self.timeLabel.width += 2*kCellSmallGap;
    self.timeLabel.top = 0;
    self.timeLabel.left = (kScreenWidth - self.timeLabel.width)/2;
    
    self.avatarImageView.size = CGSizeMake(kAvatarImageView_WH, kAvatarImageView_WH);
    
    self.nameLabel.size = CGSizeMake(kScreenWidth - kAvatarImageView_WH, kNameLable_H);
    
    self.mediaContainerrView.size = CGSizeMake(kMediaContainerrView_Max_W, layout.mediaViewSize.height);
    
    
    if (layout.isShowTimeLabel) {
        self.timeLabel.hidden = NO;
        self.avatarImageView.left = kCellMiddleGap;
        self.avatarImageView.top = kTimeLabel_H;
        self.nameLabel.left = kCellMiddleGap+kAvatarImageView_WH+kCellMiddleGap;
        self.nameLabel.top = kTimeLabel_H;
        self.mediaContainerrView.left = kCellMiddleGap+kAvatarImageView_WH+kCellSmallGap;
        self.mediaContainerrView.top = kTimeLabel_H + kNameLable_H;
    }
    else{
        self.timeLabel.hidden = YES;
        self.avatarImageView.left = kCellMiddleGap;
        self.avatarImageView.top = 0;
        self.nameLabel.left = kCellMiddleGap+kAvatarImageView_WH+kCellMiddleGap;
        self.nameLabel.top = 0;
        self.mediaContainerrView.left = kCellMiddleGap+kAvatarImageView_WH+kCellSmallGap;
        self.mediaContainerrView.top = kNameLable_H;
    }
    
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