//
//  LCWeakProxy.h
//  Pods
//
//  Created by lattecat on 2020/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id                     target;

+ (instancetype)weakProxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
