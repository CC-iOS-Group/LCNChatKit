//
//  LCNMsgHelper.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/27.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCNMsgHelper : NSObject


/**
 将NSDate按规则转换成表示时间的字符串

 @param date 传入的NSDate

 @return 时间字符串
 */
+ (NSString *)timeStringWithNSDate:(NSDate *)date;



/**
 计算语音消息气泡长度

 @param duration 毫秒，语音时长

 @return 气泡长度（有最大和最小的气泡长度限制）
 */
+ (CGFloat)audioBubbleLengthCalculatorWithDuration:(CGFloat)duration;


@end
