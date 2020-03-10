//
//  LCInfiniteThread.m
//  Interview01-Runloop
//
//  Created by lattecat on 2020/3/10.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCInfiniteThread.h"

@interface LCInfiniteThread ()

@property (nonatomic, strong) NSThread                      *thread;

@end

@implementation LCInfiniteThread

- (void)start {
    self.thread = [[NSThread alloc] initWithBlock:^{
        // 为子线程创建 Runloop 对象
        NSRunLoop *curRunLoop = [NSRunLoop currentRunLoop];
        
        // 创建 Source1 对象，添加到 runloop 中
        [curRunLoop addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        // 添加 mode
        [curRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [self.thread start];
}

- (void)stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)performBlock:(LCInfiniteThreadCallbackBlock)block {
    [self performSelector:@selector(executeInprivateThread:) onThread:self.thread withObject:block waitUntilDone:NO];
    
    // 使 runloop 继续睡眠
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}


//***********************************************************************************************************************************************************
// MARK:-                                                           LifeCycle
//***********************************************************************************************************************************************************

- (void)dealloc {
    NSLog(@"%s", __func__);
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Private
//***********************************************************************************************************************************************************

- (void)executeInprivateThread:(LCInfiniteThreadCallbackBlock)block {
    block(self);
}

@end
