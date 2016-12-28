//
//  LCFileMessageBodyModel.h
//  LittleCIM
//  @abstract 文件类型消息体
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"

@interface LCFileMessageBodyModel : LCMessageBodyModel

/**
 *  文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  原始链接
 */
@property (nonatomic, copy) NSString *originLink;

/**
 *  文件大小
 */
@property (nonatomic, assign) double fileLength;

/**
 *  文件消息体的本地沙盒文件路径（需将文件写到沙盒）
 （注：因每次app启动NSHomeDirectory()都会不同，故sdk内部会去掉NSHomeDirectory()）
 */
@property (nonatomic, copy) NSString *localPath;

/**
 *  以文件路径构造文件对象实例
 *
 *  @param localPath 本地沙盒文件路径（需将文件写到沙盒）
 *
 *  @return 文件对象实例
 */
- (instancetype)initWithLocalPath:(NSString *)localPath;

/**
 *  以文件路径构造文件对象实例
 *
 *  @param localPath 本地沙盒文件路径（需将文件写到沙盒）
 *
 *  @return 文件对象实例
 */
+ (instancetype)fileMessageWithLocalPath:(NSString *)localPath;

@end
