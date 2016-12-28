//
//  LCNInputBarFaceView.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/12/27.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNInputBarFaceView.h"

#define kInputbarFaceViewHeight 200

@implementation LCNInputBarFaceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(kScreenWidth, kInputbarFaceViewHeight);
        self.backgroundColor = [UIColor blueColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
