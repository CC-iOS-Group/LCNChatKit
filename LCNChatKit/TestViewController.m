//
//  TestViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/11/14.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YYTextView *textView = [YYTextView new];
    textView.frame = CGRectMake(0, 20, kScreenWidth, 40);
    textView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:textView];
}

- (IBAction)click:(id)sender {
    

}

@end
