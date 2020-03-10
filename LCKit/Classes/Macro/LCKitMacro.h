//
//  LCKitMacro.h
//  Pods
//
//  Created by lattecat on 2020/3/10.
//

#ifndef LCKitMacro_h
#define LCKitMacro_h

/**
 *  防止循环引用的 __weak __strong 的宏定义
 */
#define weakify(self) \
autoreleasepool{} \
__weak typeof(self) self_weak = self;

#define strongify(self) \
autoreleasepool{} \
__strong typeof(self_weak) self = self_weak;


#endif /* LCKitMacro_h */
