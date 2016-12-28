//
//  LCMessageBodyModel.h
//  LittleCIM
//  @abstract 聊天消息内容Model
//
//  Created by zhaojunjie on 16/7/20.
//  Copyright © 2016年 中移（杭州）信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCommonEnum.h"

@interface LCMessageBodyModel : NSObject

/**
 *  消息内容 type， 在 getter 方法里区分
 */
@property (nonatomic, assign, readonly) LCMessageBodyType type;

@end
