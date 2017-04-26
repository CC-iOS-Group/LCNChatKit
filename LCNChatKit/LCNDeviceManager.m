//
//  LCNDeviceManager.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/4/25.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "LCNDeviceManager.h"

@implementation LCNDeviceManager

+ (LCNDeviceManager *)sharedManager {
    static LCNDeviceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LCNDeviceManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - ProximitySensor

- (BOOL)isProximitySensorEnabled {
    return [UIDevice currentDevice].proximityMonitoringEnabled;
}

- (BOOL)enableProximitySensor {
    if (!self.isProximitySensorEnabled) {
        [UIDevice currentDevice].proximityMonitoringEnabled = YES;
        
        if (self.isProximitySensorEnabled) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(sensorStateChanged:)
                                                         name:UIDeviceProximityStateDidChangeNotification
                                                       object:nil];
            
            return YES;
        }else {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)disableProximitySensor {
    if (self.isProximitySensorEnabled) {
        [UIDevice currentDevice].proximityMonitoringEnabled = NO;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIDeviceProximityStateDidChangeNotification
                                                      object:nil];
    }
    
    return NO;
}

- (BOOL)isCloseToUser {
    return [UIDevice currentDevice].proximityState;
}

- (void)sensorStateChanged:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(deviceIsCloseToUser:)]) {
        [self.delegate deviceIsCloseToUser:[self isCloseToUser]];
    }
}

@end
