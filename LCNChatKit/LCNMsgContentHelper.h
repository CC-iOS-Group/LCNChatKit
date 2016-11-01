//
//  LCNMsgContentHelper.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/26.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCNMsgContentHelper : UIView


/**
 @XXX 用于获取@XXX的正则表达式

 @return @XXX的正则表达式
 */
+ (NSRegularExpression *)regexAt;


/**
 判断表情

 @return [哈哈]此类表情的正则表达式
 */
+ (NSRegularExpression *)regexEmoticon;


@end
