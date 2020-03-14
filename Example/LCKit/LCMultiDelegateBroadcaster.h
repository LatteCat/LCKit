//
//  LCMultiDelegateBroadcaster.h
//  LCKit_Example
//
//  Created by lattecat on 2020/3/13.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LCKit/LCMultiDelegate.h>

@protocol LCMultiDelegateBroadcaster <NSObject>

- (void)testChar:(char)charValue unsignedChar:(unsigned char)unsignedCharValue;

- (void)testInt:(int)intValue unsignedInt:(unsigned int)unsigenedIntValue;

- (void)testShort:(short)shortValue unsignedShort:(unsigned short)unsigenedShortValue;

- (void)testLong:(long)longValue unsignedLong:(unsigned long)unsigenedLongValue;

- (void)testLongLong:(long long)shortValue unsignedLongLong:(unsigned long long)unsigenedLongLongValue;

- (void)testFloat:(float)floatValue;

- (void)testDouble:(double)doubleValue;

- (void)testBool:(bool)boolValue;

- (void)testBOOL:(BOOL)boolValue;

- (void)testChar_:(char *)char_Value;

- (void)testNSObject:(NSObject *)objValue;

- (void)testClass:(Class)classValue;

- (void)testSEL:(SEL)selValue;

- (void)testInt__:(int[])int__Value;

- (void)testFloat__:(float[])float__Value;

- (void)testInt_:(int *)int_Value;

- (void)testFloat_:(float *)float_Value;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LCMultiDelegateBroadcaster : NSObject

@property (nonatomic, strong) LCMultiDelegate<LCMultiDelegateBroadcaster>                   *delegate;

- (void)addDelegates;

- (void)broadcast;

@end

@interface LCMultiDelegate1 : NSObject

@property (nonatomic, strong) dispatch_queue_t                  queue;

@end

@interface LCMultiDelegate2 : NSObject

@property (nonatomic, strong) dispatch_queue_t                  queue;

@end

@interface LCMultiDelegate3 : NSObject

@property (nonatomic, strong) dispatch_queue_t                  queue;

@end

@interface LCMultiDelegate4 : NSObject

@property (nonatomic, strong) dispatch_queue_t                  queue;

@end

@interface LCMultiDelegate5 : NSObject

@property (nonatomic, strong) dispatch_queue_t                  queue;

@end

NS_ASSUME_NONNULL_END
