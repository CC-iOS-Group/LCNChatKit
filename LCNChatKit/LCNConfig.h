//
//  LCNConfig.h
//  LCNChatKit
//
//  Created by 黄春涛 on 2017/4/26.
//  Copyright © 2017年 enrecul. All rights reserved.
//

#ifndef LCNConfig_h
#define LCNConfig_h

#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])


//录音需要的最短时间
#define MIN_RECORD_TIME_REQUIRED 1

//录音允许的最长时间
#define MAX_RECORD_TIME_ALLOWED 60

#define RECORD_AUTHORIZATION_DENIED_TEXT @"请在iPhone的“设置-隐私-麦克风”选项中，允许访问你的手机麦克风。"

#endif /* LCNConfig_h */
