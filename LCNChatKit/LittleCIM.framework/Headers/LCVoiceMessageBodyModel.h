//
//  LCVoiceMessageBodyModel.h
//  LittleCIM
//  @abstract 声音消息体
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import "LCMessageBodyModel.h"
#import "LCFileMessageBodyModel.h"

@interface LCVoiceMessageBodyModel : LCFileMessageBodyModel

/**
 *  语音的播放时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  以语音文件路径，语音时长构造文件对象实例
 *
 *  @param localPath 本地语音文件全路径
 *  @param duration   语音时长
 *
 *  @return 文件对象实例
 */
+ (instancetype)voiceMessageBodyWithLocalPath:(NSString *)localPath duration:(NSTimeInterval)duration;

@end
