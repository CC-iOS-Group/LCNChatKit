//
//  LCNRefreshView.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/2/6.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "LCNRefreshView.h"

@interface LCNRefreshView()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation LCNRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        [self addSubview:self.indicator];
        self.indicator.center = self.center;
    }
    return self;
}

#pragma mark - Public Method
- (BOOL)isAnimation{
    return self.indicator.isAnimating;
}

- (void)startAnimation{
    if (![self isAnimation]) {
        [self.indicator startAnimating];
    }
}

- (void)stopAnimation{
    if([self isAnimation]){
        [self.indicator stopAnimating];
    }
}


#pragma mark - Setter & Getter
-(UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.hidesWhenStopped = NO;
        _indicator.size = CGSizeMake(20, 20);
    }
    return _indicator;
}

@end
