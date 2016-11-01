//
//  LCNMsgHelper.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/27.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMsgHelper.h"

@implementation LCNMsgHelper

+ (NSString *)timeStringWithNSDate:(NSDate *)date{
    if (!date ) return nil ;
    NSDate *nowDate = [NSDate date];
    NSDate *oneWeekAgoDate = [nowDate dateByAddingWeeks:-1];
    NSString *timeString = nil;
    
    
    if ([date isToday]) {//昨天
        timeString = [NSString stringWithFormat:@"%ld:%2ld",date.hour,date.second];
    }
    else if([date compare:oneWeekAgoDate] == NSOrderedDescending){//一周之内，显示星期几
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE HH:mm"];
        timeString = [dateFormatter stringFromDate:date];
    }
    else{//一周之前
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        timeString = [dateFormatter stringFromDate:date];
    }
    
    return timeString;
}

@end
