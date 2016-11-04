//
//  LCNCollectionHeaderView.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/11/3.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNCollectionHeaderView.h"

@implementation LCNCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.size = CGSizeMake(kScreenWidth, 40);
        
        UIActivityIndicatorView *indicatorView = [UIActivityIndicatorView new];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        indicatorView.size = CGSizeMake(20, 20);
        indicatorView.center = self.center;
        [indicatorView startAnimating];
        
        [self addSubview:indicatorView];
        
    }
    return self;
}


@end
