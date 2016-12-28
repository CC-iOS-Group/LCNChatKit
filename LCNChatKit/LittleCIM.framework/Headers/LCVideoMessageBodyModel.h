//
//  LCVideoMessageBodyModel.h
//  LittleCIM
//  @abstract 视频消息体
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"
#import "LCFileMessageBodyModel.h"

@interface LCVideoMessageBodyModel : LCFileMessageBodyModel

/**
 *  视频截图链接
 */
@property (nonatomic, copy) NSString *videoImageLink;

/**
 *  视频的播放时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  图片宽度
 */
@property (nonatomic, assign, readonly) int32_t width;

/**
 *  图片高度
 */
@property (nonatomic, assign, readonly) int32_t height;

/**
 *  以视频文件路径，视频时长构造文件对象实例
 *
 *  @param localPath 本地视频文件全路径
 *  @param duration   视频时长
 *
 *  @return 文件对象实例
 */
+ (instancetype)videoMessageBodyWithLocalPath:(NSString *)localPath duration:(NSTimeInterval)duration;

@end
