//
//  NSInvocation+LCKit.m
//  LCKit
//
//  Created by lattecat on 2020/3/13.
//

#define LC_INVOCATION_COPY_ARGUMENTS(TYPE) \
TYPE value; \
[self getArgument:&value atIndex:idx]; \
[anInvocation setArgument:&value atIndex:idx];

/**
 *  Objective-C Type Encoding: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100
 *  https://nshipster.com/type-encodings/
 */

#import "NSInvocation+LCKit.h"

@implementation NSInvocation (LCKit)

- (instancetype)copiedInvocation {
    NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:self.methodSignature];
    anInvocation.selector = self.selector;
    anInvocation.target = self.target;
    for (NSInteger idx = 0; idx < self.methodSignature.numberOfArguments; idx++) {
        const char *type = [self.methodSignature getArgumentTypeAtIndex:idx];
        if (!strcmp(type, @encode(char)) || !strcmp(type, @encode(unsigned char))) {
            LC_INVOCATION_COPY_ARGUMENTS(char)
        } else if (!strcmp(type, @encode(int)) || !strcmp(type, @encode(unsigned int))) {
            LC_INVOCATION_COPY_ARGUMENTS(int)
        } else if (!strcmp(type, @encode(short)) || !strcmp(type, @encode(unsigned short))) {
            LC_INVOCATION_COPY_ARGUMENTS(short)
        } else if (!strcmp(type, @encode(long)) || !strcmp(type, @encode(unsigned long))) {
            LC_INVOCATION_COPY_ARGUMENTS(long)
        } else if (!strcmp(type, @encode(long long)) || !strcmp(type, @encode(unsigned long long))) {
            LC_INVOCATION_COPY_ARGUMENTS(long long)
        } else if (!strcmp(type, @encode(float))) {
            LC_INVOCATION_COPY_ARGUMENTS(float)
        } else if (!strcmp(type, @encode(double))) {
            LC_INVOCATION_COPY_ARGUMENTS(double)
        } else if (!strcmp(type, @encode(bool))) {
            // @encode(BOOL) 为 "c"，即 @encode(char)
            LC_INVOCATION_COPY_ARGUMENTS(bool)
        } else if (!strcmp(type, @encode(void))) {
        } else if (!strcmp(type, @encode(char *))) {
            LC_INVOCATION_COPY_ARGUMENTS(char *)
        } else if (!strcmp(type, @encode(NSObject *))) {
            // https://stackoverflow.com/questions/22018272/nsinvocation-returns-value-but-makes-app-crash-with-exc-bad-access
            // 在 ARC 下，`getArgument:`仅仅是将参数按照字节来复制到传入的实参中，它不会去处理传入的参数的内存管理问题
            // 默认 id value 是 __strong 类型，ARC 会认为该指针指向的对象默认已经进行了 retain 操作，在 value 到达作用域的结束时会调用 release，这样就相当于对象会提前释放了，导致了僵尸对象的出现
            // 设置为 __weak 或 __unsafe_unretained 之后，就能解决问题
            // 同理 getReturnValue: 也会有这个问题
            // LC_INVOCATION_COPY_ARGUMENTS(id) // 不能直接使用此宏定义
             NSObject * __unsafe_unretained tempValue;
            [self getArgument:&tempValue atIndex:idx];
//            NSObject *value = tempValue;
            [anInvocation setArgument:&tempValue atIndex:idx];
        } else if (!strcmp(type, @encode(Class))) {
            LC_INVOCATION_COPY_ARGUMENTS(Class)
        } else if (!strcmp(type, @encode(SEL))) {
            LC_INVOCATION_COPY_ARGUMENTS(SEL)
        } else if (type[0] == '^') {
            // A pointer to type, e.g. int*, float*
            LC_INVOCATION_COPY_ARGUMENTS(void *)
        } else {
            NSString *sel = NSStringFromSelector(self.selector);
            NSString *reason = [NSString stringWithFormat:@"Argument type %s for @selecor(%@) at %ld not supported!", type, sel, (idx - 2)];
            [[NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil] raise];
        }
    }
    if (!anInvocation.argumentsRetained) {
        [anInvocation retainArguments];
    }
    
    return anInvocation;
}

@end
