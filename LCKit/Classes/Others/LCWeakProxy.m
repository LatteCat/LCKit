//
//  LCWeakProxy.m
//  Pods
//
//  Created by lattecat on 2020/3/12.
//

#import "LCWeakProxy.h"

@implementation LCWeakProxy

- (instancetype)initWithWeakProxyWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)weakProxyWithTarget:(id)target {
    LCWeakProxy *proxy = [[self alloc] initWithWeakProxyWithTarget:target];
    return proxy;
    
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Method Forwarding
//***********************************************************************************************************************************************************

///**
// *  实现方式 2
// */
//- (id)forwardingTargetForSelector:(SEL)sel {
//    return self.target;
//}

/**
 *  实现方式 1
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (!self.target) {
        NSAssert(NO, @"LCWeakProxy 的 target 不能为 nil！");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
