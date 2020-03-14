//
//  LCMultiDelegateBroadcaster.m
//  LCKit_Example
//
//  Created by lattecat on 2020/3/13.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCMultiDelegateBroadcaster.h"

@class LCMultiDelegate1;

@interface LCMultiDelegateBroadcaster ()

@property (nonatomic, strong) NSMutableArray                        *array;

@end

@implementation LCMultiDelegateBroadcaster

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.delegate = (id<LCMultiDelegateBroadcaster>)[[LCMultiDelegate alloc] init];
    self.array = [NSMutableArray array];
    
    return self;
}

- (void)addDelegates {
    for (NSInteger i = 1; i <= 5; i++) {
        Class cls = NSClassFromString([NSString stringWithFormat:@"LCMultiDelegate%ld", i]);
        LCMultiDelegate1 *delegate = [[cls alloc] init];
        [self.array addObject:delegate];
        [self.delegate addDelegate:delegate queue:delegate.queue];
    }
    NSLog(@"%@", self.delegate);
}

- (void)broadcast {
    [self.delegate testChar:'1' unsignedChar:'A'];
    [self.delegate testInt:123 unsignedInt:456];
}

@end



@implementation LCMultiDelegate1 : NSObject

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    self.queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    return self;
}


- (void)testChar:(char)charValue unsignedChar:(unsigned char)unsignedCharValue {
    NSLog(@"%s, %@, %@, %c, %uc", __func__, self.class, self, charValue, unsignedCharValue);
}

- (void)testInt:(int)intValue unsignedInt:(unsigned int)unsigenedIntValue{
    NSLog(@"%s, %@, %@, %d, %ud", __func__, self.class, self, intValue, unsigenedIntValue);
}

- (void)testShort:(short)shortValue unsignedShort:(unsigned short)unsigenedShortValue{
    NSLog(@"%s, %@, %d, %ud", __func__, self.class, shortValue, unsigenedShortValue);
}

- (void)testLong:(long)longValue unsignedLong:(unsigned long)unsigenedLongValue{
    NSLog(@"%s, %@, %ld, %lu", __func__, self.class, longValue, unsigenedLongValue);
}

- (void)testLongLong:(long long)shortValue unsignedLongLong:(unsigned long long)unsigenedLongLongValue{
    NSLog(@"%s, %@, %lld, %lld", __func__, self.class, shortValue, unsigenedLongLongValue);
}

- (void)testFloat:(float)floatValue {
    NSLog(@"%s, %@, %f", __func__, self.class, floatValue);
}

- (void)testDouble:(double)doubleValue {
    NSLog(@"%s, %@, %f", __func__, self.class, doubleValue);
}

- (void)testBool:(bool)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testBOOL:(BOOL)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testChar_:(char *)char_Value {
    NSLog(@"%s, %@, %s", __func__, self.class, char_Value);
}

- (void)testNSObject:(NSObject *)objValue {
    NSLog(@"%s, %@, %@", __func__, self.class, objValue);
}

- (void)testClass:(Class)classValue {
    NSLog(@"%s, %@, %@", __func__, self.class, classValue);
}

- (void)testSEL:(SEL)selValue {
    NSLog(@"%s, %@, %s", __func__, self.class, sel_getName(selValue));
}

- (void)testInt__:(int[])int__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int__Value);
}

- (void)testFloat__:(float[])float__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float__Value);
}

- (void)testInt_:(int *)int_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int_Value);
}

- (void)testFloat_:(float *)float_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float_Value);
}

@end

@implementation LCMultiDelegate2 : NSObject

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    self.queue = dispatch_queue_create("queue2", DISPATCH_QUEUE_SERIAL);
    return self;
}



- (void)testChar:(char)charValue unsignedChar:(unsigned char)unsignedCharValue {
    NSLog(@"%s, %@, %@, %c, %uc", __func__, self.class, self, charValue, unsignedCharValue);
}

- (void)testInt:(int)intValue unsignedInt:(unsigned int)unsigenedIntValue{
    NSLog(@"%s, %@, %@, %d, %ud", __func__, self.class, self, intValue, unsigenedIntValue);
}

- (void)testShort:(short)shortValue unsignedShort:(unsigned short)unsigenedShortValue{
    NSLog(@"%s, %@, %d, %ud", __func__, self.class, shortValue, unsigenedShortValue);
}

- (void)testLong:(long)longValue unsignedLong:(unsigned long)unsigenedLongValue{
    NSLog(@"%s, %@, %ld, %lu", __func__, self.class, longValue, unsigenedLongValue);
}

- (void)testLongLong:(long long)shortValue unsignedLongLong:(unsigned long long)unsigenedLongLongValue{
    NSLog(@"%s, %@, %lld, %lld", __func__, self.class, shortValue, unsigenedLongLongValue);
}

- (void)testFloat:(float)floatValue {
    NSLog(@"%s, %@, %f", __func__, self.class, floatValue);
}

- (void)testDouble:(double)doubleValue {
    NSLog(@"%s, %@, %f", __func__, self.class, doubleValue);
}

- (void)testBool:(bool)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testBOOL:(BOOL)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testChar_:(char *)char_Value {
    NSLog(@"%s, %@, %s", __func__, self.class, char_Value);
}

- (void)testNSObject:(NSObject *)objValue {
    NSLog(@"%s, %@, %@", __func__, self.class, objValue);
}

- (void)testClass:(Class)classValue {
    NSLog(@"%s, %@, %@", __func__, self.class, classValue);
}

- (void)testSEL:(SEL)selValue {
    NSLog(@"%s, %@, %s", __func__, self.class, sel_getName(selValue));
}

- (void)testInt__:(int[])int__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int__Value);
}

- (void)testFloat__:(float[])float__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float__Value);
}

- (void)testInt_:(int *)int_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int_Value);
}

- (void)testFloat_:(float *)float_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float_Value);
}

@end

@implementation LCMultiDelegate3

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    return self;
}



- (void)testChar:(char)charValue unsignedChar:(unsigned char)unsignedCharValue {
    NSLog(@"%s, %@, %@, %c, %uc", __func__, self.class, self, charValue, unsignedCharValue);
}

- (void)testInt:(int)intValue unsignedInt:(unsigned int)unsigenedIntValue{
    NSLog(@"%s, %@, %@, %d, %ud", __func__, self.class, self, intValue, unsigenedIntValue);
}

- (void)testShort:(short)shortValue unsignedShort:(unsigned short)unsigenedShortValue{
    NSLog(@"%s, %@, %d, %ud", __func__, self.class, shortValue, unsigenedShortValue);
}

- (void)testLong:(long)longValue unsignedLong:(unsigned long)unsigenedLongValue{
    NSLog(@"%s, %@, %ld, %lu", __func__, self.class, longValue, unsigenedLongValue);
}

- (void)testLongLong:(long long)shortValue unsignedLongLong:(unsigned long long)unsigenedLongLongValue{
    NSLog(@"%s, %@, %lld, %lld", __func__, self.class, shortValue, unsigenedLongLongValue);
}

- (void)testFloat:(float)floatValue {
    NSLog(@"%s, %@, %f", __func__, self.class, floatValue);
}

- (void)testDouble:(double)doubleValue {
    NSLog(@"%s, %@, %f", __func__, self.class, doubleValue);
}

- (void)testBool:(bool)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testBOOL:(BOOL)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testChar_:(char *)char_Value {
    NSLog(@"%s, %@, %s", __func__, self.class, char_Value);
}

- (void)testNSObject:(NSObject *)objValue {
    NSLog(@"%s, %@, %@", __func__, self.class, objValue);
}

- (void)testClass:(Class)classValue {
    NSLog(@"%s, %@, %@", __func__, self.class, classValue);
}

- (void)testSEL:(SEL)selValue {
    NSLog(@"%s, %@, %s", __func__, self.class, sel_getName(selValue));
}

- (void)testInt__:(int[])int__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int__Value);
}

- (void)testFloat__:(float[])float__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float__Value);
}

- (void)testInt_:(int *)int_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int_Value);
}

- (void)testFloat_:(float *)float_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float_Value);
}

@end

@implementation LCMultiDelegate4

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    self.queue = dispatch_get_main_queue();
    return self;
}



- (void)testChar:(char)charValue unsignedChar:(unsigned char)unsignedCharValue {
    NSLog(@"%s, %@, %@, %c, %uc", __func__, self.class, self, charValue, unsignedCharValue);
}

- (void)testInt:(int)intValue unsignedInt:(unsigned int)unsigenedIntValue{
    NSLog(@"%s, %@, %@, %d, %ud", __func__, self.class, self, intValue, unsigenedIntValue);
}

- (void)testShort:(short)shortValue unsignedShort:(unsigned short)unsigenedShortValue{
    NSLog(@"%s, %@, %d, %ud", __func__, self.class, shortValue, unsigenedShortValue);
}

- (void)testLong:(long)longValue unsignedLong:(unsigned long)unsigenedLongValue{
    NSLog(@"%s, %@, %ld, %lu", __func__, self.class, longValue, unsigenedLongValue);
}

- (void)testLongLong:(long long)shortValue unsignedLongLong:(unsigned long long)unsigenedLongLongValue{
    NSLog(@"%s, %@, %lld, %lld", __func__, self.class, shortValue, unsigenedLongLongValue);
}

- (void)testFloat:(float)floatValue {
    NSLog(@"%s, %@, %f", __func__, self.class, floatValue);
}

- (void)testDouble:(double)doubleValue {
    NSLog(@"%s, %@, %f", __func__, self.class, doubleValue);
}

- (void)testBool:(bool)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testBOOL:(BOOL)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testChar_:(char *)char_Value {
    NSLog(@"%s, %@, %s", __func__, self.class, char_Value);
}

- (void)testNSObject:(NSObject *)objValue {
    NSLog(@"%s, %@, %@", __func__, self.class, objValue);
}

- (void)testClass:(Class)classValue {
    NSLog(@"%s, %@, %@", __func__, self.class, classValue);
}

- (void)testSEL:(SEL)selValue {
    NSLog(@"%s, %@, %s", __func__, self.class, sel_getName(selValue));
}

- (void)testInt__:(int[])int__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int__Value);
}

- (void)testFloat__:(float[])float__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float__Value);
}

- (void)testInt_:(int *)int_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int_Value);
}

- (void)testFloat_:(float *)float_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float_Value);
}

@end

@implementation LCMultiDelegate5

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    self.queue = dispatch_queue_create("queue5", DISPATCH_QUEUE_CONCURRENT);
    return self;
}



- (void)testChar:(char)charValue unsignedChar:(unsigned char)unsignedCharValue {
    NSLog(@"%s, %@, %@, %c, %uc", __func__, self.class, self, charValue, unsignedCharValue);
}

- (void)testInt:(int)intValue unsignedInt:(unsigned int)unsigenedIntValue{
    NSLog(@"%s, %@, %@, %d, %ud", __func__, self.class, self, intValue, unsigenedIntValue);
}

- (void)testShort:(short)shortValue unsignedShort:(unsigned short)unsigenedShortValue{
    NSLog(@"%s, %@, %d, %ud", __func__, self.class, shortValue, unsigenedShortValue);
}

- (void)testLong:(long)longValue unsignedLong:(unsigned long)unsigenedLongValue{
    NSLog(@"%s, %@, %ld, %lu", __func__, self.class, longValue, unsigenedLongValue);
}

- (void)testLongLong:(long long)shortValue unsignedLongLong:(unsigned long long)unsigenedLongLongValue{
    NSLog(@"%s, %@, %lld, %lld", __func__, self.class, shortValue, unsigenedLongLongValue);
}

- (void)testFloat:(float)floatValue {
    NSLog(@"%s, %@, %f", __func__, self.class, floatValue);
}

- (void)testDouble:(double)doubleValue {
    NSLog(@"%s, %@, %f", __func__, self.class, doubleValue);
}

- (void)testBool:(bool)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testBOOL:(BOOL)boolValue {
    NSLog(@"%s, %@, %d", __func__, self.class, boolValue);
}

- (void)testChar_:(char *)char_Value {
    NSLog(@"%s, %@, %s", __func__, self.class, char_Value);
}

- (void)testNSObject:(NSObject *)objValue {
    NSLog(@"%s, %@, %@", __func__, self.class, objValue);
}

- (void)testClass:(Class)classValue {
    NSLog(@"%s, %@, %@", __func__, self.class, classValue);
}

- (void)testSEL:(SEL)selValue {
    NSLog(@"%s, %@, %s", __func__, self.class, sel_getName(selValue));
}

- (void)testInt__:(int[])int__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int__Value);
}

- (void)testFloat__:(float[])float__Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float__Value);
}

- (void)testInt_:(int *)int_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, int_Value);
}

- (void)testFloat_:(float *)float_Value {
    NSLog(@"%s, %@, %p", __func__, self.class, float_Value);
}

@end
