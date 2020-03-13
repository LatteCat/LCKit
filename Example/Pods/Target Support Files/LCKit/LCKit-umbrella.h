#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LCKit.h"
#import "LCKitMacro.h"
#import "LCWeakProxy.h"
#import "LCInfiniteThread.h"
#import "LCThreadSafeArray.h"
#import "UIView+Frame.h"

FOUNDATION_EXPORT double LCKitVersionNumber;
FOUNDATION_EXPORT const unsigned char LCKitVersionString[];

