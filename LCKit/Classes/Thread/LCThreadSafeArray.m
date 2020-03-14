//
//  LCThreadSafeArray.m
//  LCKit
//
//  Created by lattecat on 2020/3/12.
//

#import "LCThreadSafeArray.h"
#import <pthread.h>
#import <objc/runtime.h>

#define LC_WRITE_LOCK(OPS, RETURN) \
if (self.concurrentRead) { \
pthread_rwlock_wrlock(self.rwlock); \
OPS;\
pthread_rwlock_unlock(self.rwlock); \
return RETURN; \
} else { \
dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER); \
OPS;\
dispatch_semaphore_signal(self.semaphore); \
return RETURN; \
}

#define LC_READ_LOCK(OPS, RETURN) \
if (self.concurrentRead) { \
pthread_rwlock_rdlock(self.rwlock); \
OPS;\
pthread_rwlock_unlock(self.rwlock); \
return RETURN; \
} else { \
dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER); \
OPS;\
dispatch_semaphore_signal(self.semaphore); \
return RETURN; \
}

@interface LCThreadSafeArray<ObjectType> ()

/**
 *  内部的容器数组
 */
@property (nonatomic, strong) NSMutableArray<ObjectType>                *containerArray;

/**
 *  是否允许并发“读取”操作，YES 代表与数组的“读取”相关操作会并发执行，
 *  NO 则表示“读取”相关操作也会与“写入”操作一样顺序执行。
 */
@property (nonatomic, assign) BOOL                                      concurrentRead;

/**
 *  执行“单读单写”的信号量
 */
@property (nonatomic, strong) dispatch_semaphore_t                      semaphore;

/**
 *  执行“多读单写”的锁
 */
@property (nonatomic, assign) pthread_rwlock_t                          *rwlock;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation LCThreadSafeArray

- (instancetype)initWithArray:(NSArray *)array concurrentRead:(BOOL)concurrentRead {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.containerArray = [NSMutableArray arrayWithArray:array ?: @[]];
    self.concurrentRead = concurrentRead;
    
    // 初始化锁
    if (concurrentRead) {
        pthread_rwlock_t lock;
        pthread_rwlock_init(&lock, nil);
        self.rwlock = &lock;
    } else {
        self.semaphore = dispatch_semaphore_create(1);
    }
    
    return self;
}

- (instancetype)init {
    self = [self initWithArray:@[] concurrentRead:YES];
    return self;
}

- (void)dealloc {
    pthread_rwlock_destroy(self.rwlock);
}


//***********************************************************************************************************************************************************
// MARK:-                                                           READ OPS
//***********************************************************************************************************************************************************

//- (NSInteger)count {
//    LC_READ_LOCK(NSUInteger count = self.containerArray.count, count)
//}
//
//- (id)objectAtIndex:(NSUInteger)index {
//    LC_READ_LOCK(id obj = [self.containerArray objectAtIndex:index], obj)
//}
//
//- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes {
//    LC_READ_LOCK(NSArray *objs = [self.containerArray objectsAtIndexes:indexes], objs)
//}
//
//- (NSUInteger)indexOfObject:(id)anObject {
//    LC_READ_LOCK(NSUInteger index = [self.containerArray indexOfObject:anObject], index)
//}



//***********************************************************************************************************************************************************
// MARK:-                                                           WRITE OPS
//***********************************************************************************************************************************************************

//- (void)addObject:(id)object {
//    LC_WRITE_LOCK([self.containerArray addObject:object], )
//}
//
//- (void)insertObject:(id)object atIndex:(NSUInteger)index {
//    LC_WRITE_LOCK([self.containerArray insertObject:object atIndex:index], )
//}
//
//- (void)removeObjectAtIndex:(NSUInteger)index {
//    LC_WRITE_LOCK([self.containerArray removeObjectAtIndex:index], )
//}


//***********************************************************************************************************************************************************
// MARK:-                                                           Private
//***********************************************************************************************************************************************************

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    Method m =  class_getInstanceMethod(self.containerArray.class, aSelector);
//    return [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(m)];
    return [self.containerArray methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (!self.concurrentRead) {
        // 单写单读
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        [anInvocation invokeWithTarget:self.containerArray];
        dispatch_semaphore_signal(self.semaphore);
    } else {
        // 多读单写
        // 返回值为 void 基本就是“写入”操作，反之则为“读取”操作
        // strcmp s1 > s2 返回正数，s1 < s2 返回负数，s1 = s2 返回 0
        BOOL writeOpt = !strcmp(anInvocation.methodSignature.methodReturnType, "v");
        if (writeOpt) {
            // 写入
            pthread_rwlock_wrlock(self.rwlock);
            [anInvocation invokeWithTarget:self.containerArray];
            pthread_rwlock_unlock(self.rwlock);
        } else {
            // 读取
            pthread_rwlock_rdlock(self.rwlock);
            [anInvocation invokeWithTarget:self.containerArray];
            pthread_rwlock_unlock(self.rwlock);
        }
    }
}


@end
#pragma clang diagnostic pop
