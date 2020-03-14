//
//  LCThreadSafeArray.h
//  LCKit
//
//  Created by lattecat on 2020/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCThreadSafeArray<ObjectType> : NSObject

/**
 *  根据已有的数组创建一个线程安全数组
 *  @param array 数组的初始成员
 *  @param concurrentRead 是否允许并发“读取”操作，YES 代表与数组的“读取”相关操作会并发执行，
 *  NO 则表示“读取”相关操作也会与“写入”操作一样顺序执行。
 */
- (instancetype)initWithArray:(NSArray<ObjectType> * __nullable)array concurrentRead:(BOOL)concurrentRead;

/**
 *  数组元素数量
 */
- (NSInteger)count;

- (ObjectType)objectAtIndex:(NSUInteger)index;
- (NSArray<ObjectType> *)objectsAtIndexes:(NSIndexSet *)indexes;

- (NSUInteger)indexOfObject:(ObjectType)anObject;
- (BOOL)containsObject:(ObjectType)anObject;

/**
 *  向数组的最末端添加一个成员
 */
- (void)addObject:(ObjectType)object;

- (void)insertObject:(ObjectType)object atIndex:(NSUInteger)index;

- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeObject:(ObjectType)anObject;
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
