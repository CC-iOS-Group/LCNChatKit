//
//  LCNCollectionViewCell.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNMessageLayout.h"

#define kAvatarImageView_WH 40.0
#define kTimeLabel_H 20.0
#define kNameLable_H 20.0
#define kStatusLabel_H 20.0
#define kMediaContainerrView_Max_W (kScreenWidth - kAvatarImageView_WH*2)

@interface LCNCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYLabel *timeLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) UIView *mediaContainerrView;
@property (nonatomic, strong) YYLabel *statusLabel;

@property (nonatomic, strong) UIImageView *unreadRedPointView;

@property (nonatomic, strong) LCNMessageLayout *layout;

-(void)setLayout:(LCNMessageLayout *)layout;

@end
