//
//  HUD.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/5/4.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "HUD.h"
#import "SVProgressHUD.h"

@implementation HUD

+(void)showInfoWithStatus:(NSString *)status delay:(NSTimeInterval)delay{
    [SVProgressHUD showInfoWithStatus:status];
    [SVProgressHUD dismissWithDelay:delay];
}
@end
