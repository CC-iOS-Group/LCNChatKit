//
//  LCResendMessageModel.h
//  LittleCIMDemo
//
//  Created by shenhongbang on 16/8/19.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <LittleCIM/LittleCIM.h>

@interface LCResendMessageModel : LCMessageModel

/**
 *  首次重发时间
 */
@property (nonatomic, assign) NSTimeInterval firstSendTime;


/**
 *  重发次数
 */
@property (nonatomic, assign) NSInteger resendNum;


@end
