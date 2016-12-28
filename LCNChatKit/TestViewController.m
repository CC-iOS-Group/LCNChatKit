//
//  TestViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/11/14.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "TestViewController.h"
#import <LittleCIM/LittleCIM.h>

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *appkey = @"116894fg";
//        appkey = @"222222vv";
    NSString *appkeyPassword = @"835f4d17921c3d131bea0b38949c94d0";
//    NSString *appkeyPassword = @"123456";

    LCOptions *options = [LCOptions optionsWithAppkey:appkey appkeyPassword:appkeyPassword];
    options.logLevel = LCLogLevelAll;
    
    [[LCClient sharedInstance] initializeSDKWithOptions:options handler:^(LCError *error) {
        //配置是否成功
    }];
//    [[LCClient sharedInstance].pushManager registerPushNotifications];
    
}

- (IBAction)click:(id)sender {
    
    NSString *userName = @"aaa111";
    NSString *password = @"hct199056";
    NSString *nickName = @"aaa111";
//    NSString *phone = @"13567856756";
    
    
    [[LCClient sharedInstance] createAccountWithUserName:userName password:password nickName:nickName phone:nil handler:^(LCError *error) {
        if (error == nil)
        {
            NSLog(@"注册成功");
//    
//            [[LCClient sharedInstance] loginWithUserName:userName password:password handler:^(LCError *error, LCUserInfoModel *userInfoModel) {
//                
//                if (error == nil)
//                {
//                    NSLog(@"登录成功");
//                    [[LCClient sharedInstance].options setBIsAutoLogin:true];
//                    //            [[LCClient sharedInstance].pushManager subscribePushNotificationsWithHandler:nil];
//                }
//                else
//                {
//                    NSLog(@"登录失败：%@", error);
//                }
//            }];
            
        }
        else{
            NSLog(@"注册失败");
        }
    }];
    

    

}

@end
