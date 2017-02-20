//
//  LCNAudioManager.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/2/8.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCNAudioPlayDelegate.h"
#import "LCNAudioRecordDelegate.h"

@interface LCNAudioManager : NSObject

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) BOOL isPlaying;

+(instancetype)sharedManager;



@end
