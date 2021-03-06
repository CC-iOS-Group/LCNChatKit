//
//  LCNCollectionViewCell.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/29.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNMessageLayout.h"
#import "LCNCollectionViewCellDelegate.h"

#define kAvatarImageView_WH 40.0
#define kTimeLabel_H 20.0
#define kNameLable_H 15.0
#define kStatusLabel_H 20.0
#define kMediaContainerrView_Max_W ((kScreenWidth-kAvatarImageView_WH*2)*0.65)
#define kCellMiddleGap 10
#define kCellSmallGap 5


@interface LCNCollectionViewCell : UICollectionViewCell

//UI控件
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) UIView *mediaContainerrView;///>气泡视图
@property (nonatomic, strong) YYLabel *statusLabel;

@property (nonatomic, strong) UIImageView *unreadRedPointView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;//发送中指示器

//数据源
@property (nonatomic, strong) LCNMessageLayout *layout;

@property (nonatomic, weak) id<LCNCollectionViewCellDelegate> delegate;

-(void)setLayout:(LCNMessageLayout *)layout;

@end
