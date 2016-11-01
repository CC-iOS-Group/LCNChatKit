//
//  LCNMsgHelper.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/27.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMsgHelper.h"
#import "LCNCollectionViewCell.h"

#define kAudio_MAX_Length (120*1000) //语音最长两分钟
#define kAudioBubble_MIN_Length (80)

@implementation LCNMsgHelper

+ (NSString *)timeStringWithNSDate:(NSDate *)date{
    if (!date ) return nil ;
    NSDate *nowDate = [NSDate date];
    NSDate *oneWeekAgoDate = [nowDate dateByAddingWeeks:-1];
    NSString *timeString = nil;
    
    
    if ([date isToday]) {//昨天
        timeString = [NSString stringWithFormat:@"%ld:%2ld",date.hour,(long)date.second];
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

+ (CGFloat)audioBubbleLengthCalculatorWithDuration:(CGFloat)duration{
    
    if(duration <= 0) return kAudioBubble_MIN_Length;
    
    if ((duration/kAudio_MAX_Length)>1) {
        return kMediaContainerrView_Max_W;
    }
    else{
        return (duration/kAudio_MAX_Length)*(kMediaContainerrView_Max_W-kAudioBubble_MIN_Length)+kAudioBubble_MIN_Length;
    }
    
}

@end
