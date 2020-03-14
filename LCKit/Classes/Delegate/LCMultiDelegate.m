//
//  LCMultiDelegate.m
//  LCKit
//
//  Created by lattecat on 2020/3/13.
//
#define LC_MULTIDELEGATE_LOCK dispatch_semaphore_wait(self.semaphore,DISPATCH_TIME_FOREVER);
#define LC_MULTIDELEGATE_UNLOCK dispatch_semaphore_signal(self.semaphore);


#import "LCMultiDelegate.h"
#import "NSInvocation+LCKit.h"

@interface LCMultiDelegateNode<ObjectType> : NSObject

@property (nonatomic, strong) dispatch_queue_t                          queue;
@property (nonatomic, weak) ObjectType                                  delegate;

+ (instancetype)nodeWithDelegate:(ObjectType)delegate queue:(dispatch_queue_t)queue;

@end

@implementation LCMultiDelegateNode

+ (instancetype)nodeWithDelegate:(id)delegate queue:(dispatch_queue_t)queue {
    LCMultiDelegateNode *node = [[LCMultiDelegateNode alloc] init];
    node.delegate = delegate;
    node.queue = queue;
    return node;
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Override
//***********************************************************************************************************************************************************

- (NSUInteger)hash {
    return [self.delegate hash];
}

- (BOOL)isEqual:(LCMultiDelegateNode *)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:self.class]) {
        return NO;
    } else {
        return [self.delegate isEqual:object.delegate];
    }
}

@end

@interface LCMultiDelegate ()

@property (nonatomic, strong) NSMutableArray<LCMultiDelegateNode *>                     *nodes;

@property (nonatomic, strong) dispatch_semaphore_t                                      semaphore;

@end

@implementation LCMultiDelegate

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.nodes = [NSMutableArray array];
    self.semaphore = dispatch_semaphore_create(1);
    
    return self;
}

- (void)doNothing {
    
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Public
//***********************************************************************************************************************************************************

- (void)addDelegate:(id)delegate queue:(nonnull dispatch_queue_t)queue{
    if (!delegate) {
        return ;
    }
    LC_MULTIDELEGATE_LOCK
    LCMultiDelegateNode *node = [LCMultiDelegateNode nodeWithDelegate:delegate queue:queue];
    if (![self.nodes containsObject:node]) {
        [self.nodes addObject:node];
    }
    LC_MULTIDELEGATE_UNLOCK
}

- (void)removeDelegate:(id)delegate {
    if (!delegate) {
        return ;
    }
    LC_MULTIDELEGATE_LOCK
    LCMultiDelegateNode *node = [LCMultiDelegateNode nodeWithDelegate:delegate queue:nil];
    [self.nodes removeObject:node];
    LC_MULTIDELEGATE_UNLOCK
}

- (void)removeAllDelegates {
    LC_MULTIDELEGATE_LOCK
    if (self.nodes.count) {
        [self.nodes removeAllObjects];
    }
    LC_MULTIDELEGATE_UNLOCK
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Private
//***********************************************************************************************************************************************************

- (BOOL)respondsToSelector:(SEL)aSelector {
    LC_MULTIDELEGATE_LOCK
    __block BOOL response = NO;
    [self.nodes enumerateObjectsUsingBlock:^(LCMultiDelegateNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.delegate respondsToSelector:aSelector]) {
            response = YES;
            *stop = YES;
        }
    }];
    LC_MULTIDELEGATE_UNLOCK
    return response;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    LC_MULTIDELEGATE_LOCK
    __block NSMethodSignature *result = nil;
    [self.nodes enumerateObjectsUsingBlock:^(LCMultiDelegateNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMethodSignature *sig = [obj.delegate methodSignatureForSelector:aSelector];
        if (sig) {
            result = sig;
        }
    }];
    
    // 如果所有的节点都没有实现该方法，那么就执行默认的方法 doNothing，防止崩溃
    if (!result) {
        result = [self.class instanceMethodSignatureForSelector:aSelector];
    }
    LC_MULTIDELEGATE_UNLOCK
    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 消息分发
    LC_MULTIDELEGATE_LOCK
    for (NSUInteger i = 0; i < self.nodes.count; i++) {
        LCMultiDelegateNode *node = self.nodes[i];
        if ([node.delegate respondsToSelector:anInvocation.selector]) {
            id target = node.delegate;
//            NSLog(@"*********SELECTOR:%s, TARGET:%@", anInvocation.selector, target);
            dispatch_async(node.queue, ^{
//                NSLog(@"*********SELECTOR:%s, TARGET:%@", anInvocation.selector, target);
                [anInvocation invokeWithTarget:target];
            });
        }
    }
//    [self.nodes enumerateObjectsUsingBlock:^(LCMultiDelegateNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        dispatch_async(obj.queue, ^{
//            [anInvocation invokeWithTarget:obj.delegate];
//        });
//    }];
    LC_MULTIDELEGATE_UNLOCK
}

@end
