//
//  LCNChatMessagesManager.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/5/10.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LCNMessageLayout;

@interface LCNChatMessagesManager : NSObject

- (NSInteger)messagesCount;

- (NSMutableArray *)dataSource;

- (LCNMessageLayout *)messageLayoutAtIndexPath:(NSIndexPath *)indexPath;

- (void)insertMessagesIntoDataSource:(NSArray<LCNMessageLayout *> *)messageArray atIndex:(NSInteger)index;

- (void)deleteMessageFromDataSourceWithMessageModel:(LCNMessageLayout *)messageModel;

- (void)deleteMessageFromDataSourceWithIndexPath:(NSIndexPath *) indexPath;

- (LCNMessageLayout *)lastestMessageLayout;

@end
