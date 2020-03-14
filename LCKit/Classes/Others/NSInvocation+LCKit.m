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
            LC_INVOCATION_COPY_ARGUMENTS(NSObject *)
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
    [anInvocation retainArguments];
    
    return anInvocation;
}

@end
