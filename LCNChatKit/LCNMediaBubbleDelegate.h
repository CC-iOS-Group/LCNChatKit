//
//  LCNMediaItemProtocol.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/9.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LCNMediaBubbleDelegate <NSObject>

- (UIView *)mediaView;

- (CGSize)mediaViewDisplaySize;


@end
