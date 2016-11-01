//
//  LCNLocationMediaItem.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/19.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNMediaItem.h"
#import <MapKit/MapKit.h>

@interface LCNLocationMediaItem : LCNMediaItem<LCNMediaItemProtocol>

@property (copy, nonatomic) CLLocation *location;

@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

@end
