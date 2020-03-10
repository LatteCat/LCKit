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

typedef void (^LCInfiniteThreadCallbackBlock)(LCInfiniteThread *);

@interface LCInfiniteThread : NSObject

- (void)performBlock:(LCInfiniteThreadCallbackBlock)block;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
