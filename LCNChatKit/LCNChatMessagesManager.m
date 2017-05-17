//
//  LCNChatMessagesManager.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/5/10.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import "LCNChatMessagesManager.h"
#import "LCNMessageLayout.h"

@interface LCNChatMessagesManager()

@property (nonatomic, strong) NSMutableArray<LCNMessageLayout *> *dataSource;

@end

@implementation LCNChatMessagesManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray new];
    }
    return self;
}

#pragma mark - 数据源管理方法
- (NSInteger)messagesCount{
    return self.dataSource.count;
}

- (LCNMessageLayout *)messageLayoutAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource objectOrNilAtIndex:indexPath.row];
}

- (void)insertMessagesIntoDataSource:(NSArray<LCNMessageLayout *> *)messageArray
                         atIndex:(NSInteger)index{
    [self.dataSource insertObjects:messageArray atIndex:index];
}

- (void)deleteMessageFromDataSourceWithMessageLayout:(LCNMessageLayout *)messageLayout{
    [self.dataSource removeObject:messageLayout];
}

- (void)deleteMessageFromDataSourceWithIndexPath:(NSIndexPath *) indexPath{
    [self.dataSource removeObjectAtIndex:indexPath.row];
}

- (LCNMessageLayout *)lastestMessageLayout{
    return self.dataSource.lastObject;
}


#pragma mark - Setter & Getter
- (NSMutableArray *)dataSource{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
