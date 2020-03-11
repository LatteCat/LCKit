//
//  LCThreadExampleViewController.m
//  LCKit_Example
//
//  Created by lattecat on 2020/3/10.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCThreadExampleViewController.h"
#import <LCKit/LCInfiniteThread.h>

@interface LCThreadExampleViewController ()

@property (nonatomic, strong) LCInfiniteThread                  *thread;

@end

@implementation LCThreadExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"“不死”线程";
    
    self.thread = [[LCInfiniteThread alloc] init];
    [self.thread start];
}

- (IBAction)doSomthingInSubThread:(id)sender {
    [self.thread performTaskBlock:^(LCInfiniteThread * _Nonnull thread) {
        NSLog(@"执行任务！%@", self.thread);
    }];
    NSLog(@"------------");
}

- (IBAction)stopThread:(id)sender {
    [self.thread stop];
}

- (void)dealloc {
    NSLog(@"%@ 销毁！", self.class);
    
    // 退出时，如果没有调用过 stop，那么就必须要调用一次，不然会有内存泄漏
    [self.thread stop];
}

//- (id)forwardingTargetForSelector:(SEL)aSelector

@end
