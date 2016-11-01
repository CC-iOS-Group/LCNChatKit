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

@end
