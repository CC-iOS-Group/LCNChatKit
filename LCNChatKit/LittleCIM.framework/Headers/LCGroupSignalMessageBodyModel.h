//
//  LCGroupSignalMessageBodyModel.h
//  LittleCIMDemo
//
//  Created by yyy on 16/9/10.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"
#import "LCMessageModel.h"

@interface LCGroupSignalMessageBodyModel : LCMessageBodyModel

/**
 *  群信令类型，在初始化的时候赋值
 */
@property(nonatomic, assign)LCGroupSignalType groupSignal;

/**
 *  由群信令转成的文本内容
 */
@property(nonatomic, copy)NSString *text;

+ (instancetype)groupSignalMessageBodyWithText:(NSString *)text withGroupSignal:(LCGroupSignalType)groupSignal;

@end
