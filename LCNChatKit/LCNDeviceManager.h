//
//  LCNDeviceManager.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/4/25.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LCNDeviceManagerDelegate <NSObject>

//当手机靠近或者离开耳朵时,回调该方法
- (void)deviceIsCloseToUser:(BOOL)isCloseToUser;

@end

@interface LCNDeviceManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, weak) id<LCNDeviceManagerDelegate> delegate;

- (BOOL)isCloseToUser;
- (BOOL)isProximitySensorEnabled;
- (BOOL)enableProximitySensor;
- (BOOL)disableProximitySensor;

@end
