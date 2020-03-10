//
//  LCInfiniteThread.m
//  Interview01-Runloop
//
//  Created by lattecat on 2020/3/10.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCInfiniteThread.h"
#import "LCKitMacro.h"

@interface LCInfiniteThread ()

@property (nonatomic, strong) NSThread                      *thread;

@end

@implementation LCInfiniteThread

- (void)start {
    // 如果子线程已经存在，那么就停止之前的，再重新创建新的子线程
    if (self.thread) {
        [self stop];
    }
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(initRunLoopAndKeepAlive) object:nil];
    [self.thread start];
}

- (void)stop {
    [self performTaskBlock:^(LCInfiniteThread * _Nonnull thread) {
        CFRunLoopStop(CFRunLoopGetCurrent());
        self.thread = nil;
    }];
}

- (void)performTaskBlock:(LCInfiniteThreadTaskBlock)block {
    if (!self.thread) return;
    [self performSelector:@selector(executeInThread:) onThread:self.thread withObject:block waitUntilDone:YES];
}


//***********************************************************************************************************************************************************
// MARK:-                                                           LifeCycle
//***********************************************************************************************************************************************************

- (void)dealloc {
    [self stop];
    NSLog(@"线程对象销毁！");
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Private
//***********************************************************************************************************************************************************

- (void)executeInThread:(LCInfiniteThreadTaskBlock)block {
    block(self);
}

/**
 *  创建线程内部的 RunLoop 并保活
 */
- (void)initRunLoopAndKeepAlive {
    // 创建 Source1 对象，添加到 runloop 中
    CFRunLoopSourceContext context = {0};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
    
    // 将 mode 添加到 RunLoop 中
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
}

@end
 
