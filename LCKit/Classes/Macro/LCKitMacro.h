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
try{}@catch(NSException *e){} \
__weak typeof(self) self_weak = self;

#define strongify(self) \
try{}@catch(NSException *e){} \
__strong typeof(self_weak) self = self_weak;

/**
 *  用于执行 Block
 *  @warning 注意在 C++ 中使用此宏定义没有返回值，如果需要获取 block 返回值，请手动实现；
 */
#ifdef __cplusplus
#define PERFORM_SAFE_BLOCK(block, ...)          if (block) { block(__VA_ARGS__); }
#else
#define PERFORM_SAFE_BLOCK(block, ...)          (block) ? block(__VA_ARGS__) : nil;
#endif


#endif /* LCKitMacro_h */
