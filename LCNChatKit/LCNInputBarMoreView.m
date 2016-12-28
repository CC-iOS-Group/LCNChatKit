//
//  LCNInputBarMoreView.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/12/27.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNInputBarMoreView.h"

#define kInputBarMoreViewHeight 250

@implementation LCNInputBarMoreView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(kScreenWidth, kInputBarMoreViewHeight);
        self.backgroundColor = [UIColor yellowColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
