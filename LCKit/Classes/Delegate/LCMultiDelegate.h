//
//  LCMultiDelegate.h
//  LCKit
//
//  Created by lattecat on 2020/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCMultiDelegate<ObjectType> : NSObject

- (void)addDelegate:(ObjectType)delegate queue:(dispatch_queue_t)queue;

- (void)removeDelegate:(ObjectType)delegate;

- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END
