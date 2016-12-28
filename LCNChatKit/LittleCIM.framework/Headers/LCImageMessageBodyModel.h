//
//  LCImageMessageBodyModel.h
//  LittleCIM
//  @abstract 图片消息体
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"
#import "LCFileMessageBodyModel.h"

@interface LCImageMessageBodyModel : LCFileMessageBodyModel

/**
 *  大图链接
 */
@property (nonatomic, copy) NSString *bigLink;

/**
 *  中图链接
 */
@property (nonatomic, copy) NSString *middleLink;

/**
 *  小图链接
 */
@property (nonatomic, copy) NSString *smallLink;

/**
 *  客户端发送的是否是原图
 */
@property (nonatomic, assign) BOOL  isOrigin;

/**
 *  客户端发送的是否是gif图
 */
@property (nonatomic, assign, readonly) BOOL isGif;

/**
 *  图片缩略图宽度
 */
@property (nonatomic, assign, readonly) int32_t smallWidth;

/**
 *  图片缩略图高度
 */
@property (nonatomic, assign, readonly) int32_t smallHeight;

/**
 *  图片中图宽度
 */
@property (nonatomic, assign, readonly) int32_t middleWidth;

/**
 *  图片中图高度
 */
@property (nonatomic, assign, readonly) int32_t middleHeight;

/**
 *  以图片文件路径构造文件对象实例
 *
 *  @param localPath 本地图片文件全路径
 *
 *  @return 文件对象实例
 */
+ (instancetype)imageMessageBodyWithLocalPath:(NSString *)localPath;

@end
