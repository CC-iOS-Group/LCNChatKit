//
//  LCLocationMessageBodyModel.h
//  LittleCIM
//  @abstract 位置消息体
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCFileMessageBodyModel.h"
#import <UIKit/UIKit.h>

@interface LCLocationMessageBodyModel : LCFileMessageBodyModel

/**
 *  缩略图宽度
 */
@property (nonatomic, assign, readonly) int32_t smallWidth;

/**
 *  缩略图高度
 */
@property (nonatomic, assign, readonly) int32_t smallHeight;

/**
 *  纬度
 */
@property (nonatomic, assign) CGFloat latitude;

/**
 *  经度
 */
@property (nonatomic, assign) CGFloat longitude;

/**
 *  位置描述信息
 */
@property (nonatomic, copy) NSString *locationDesc;

/**
 位置地址
 */
@property (nonatomic , copy) NSString *locationAddress;

/**
 *  以文件路径，经纬度构造文件对象实例
 *
 *  @param localPath 本地文件全路径
 *  @param latitude  纬度
 *  @param longitude 经度
 *
 *  @return 文件对象实例
 */
+ (instancetype)locationMessageBodyWithLocalPath:(NSString *)localPath latitude:(CGFloat)latitude longitude:(CGFloat)longitude;

@end
