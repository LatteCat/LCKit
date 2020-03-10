//
//  LCInfiniteThread.h
//  Interview01-Runloop
//
//  Created by lattecat on 2020/3/10.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LCInfiniteThread;

typedef void (^LCInfiniteThreadTaskBlock)(LCInfiniteThread *thread);

@interface LCInfiniteThread : NSObject

/**
 *  创建子线程，开始接受任务
 *  @warning 在决定不再使用此线程时，一定要调用一次 @c stop 方法
 */
- (void)start;

/**
 *  销毁子线程
 *  @warning 不再使用此线程时，必须要调用一次此方法，不然会造成内存泄露
 */
- (void)stop;

/**
 *  在子线程内部执行任务
 */
- (void)performTaskBlock:(LCInfiniteThreadTaskBlock)block;

@end

NS_ASSUME_NONNULL_END
