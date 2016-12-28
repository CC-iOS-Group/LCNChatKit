//
//  LCUserInfoModel.h
//  LittleCIMDemo
//
//  Created by yyy on 16/9/26.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUserInfoModel : NSObject

/*
 *  用户个人信息：用户名、昵称、电话号
 */
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *phone;

@end
