//
//  LCImageFactory.h
//  LCKit
//
//  Created by lattecat on 2020/4/1.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, kLCImageClipRoundRectOption) {
    kLCImageClipRoundRectOptionNone = 0,                        // 不设定圆角
    kLCImageClipRoundRectOptionTopLeft = 1 << 0,                // 圆角矩形左上角
    kLCImageClipRoundRectOptionTopRight = 1 << 1,               // 圆角矩形右上角
    kLCImageClipRoundRectOptionBottomLeft = 1 << 2,             // 圆角矩形左下角
    kLCImageClipRoundRectOptionBottonRight = 1 << 3,            // 圆角矩形右下角
    kLCImageClipRoundRectOptionTop = kLCImageClipRoundRectOptionTopLeft | kLCImageClipRoundRectOptionTopRight,
    kLCImageClipRoundRectOptionBottom = kLCImageClipRoundRectOptionBottomLeft | kLCImageClipRoundRectOptionBottonRight,
    kLCImageClipRoundRectOptionLeft = kLCImageClipRoundRectOptionTopLeft | kLCImageClipRoundRectOptionBottomLeft,
    kLCImageClipRoundRectOptionRight = kLCImageClipRoundRectOptionTopRight | kLCImageClipRoundRectOptionBottonRight,
    kLCImageClipRoundRectOptionAll = kLCImageClipRoundRectOptionTop | kLCImageClipRoundRectOptionBottom
};

typedef NS_ENUM(NSUInteger, kLCImageContentMode) {
    kLCImageContentModeScaleToFill,
    kLCImageContentModeAspectFit,
    kLCImageContentModeAspectFill,
    kLCImageContentModeCenter,
    kLCImageContentModeTop,
    kLCImageContentModeBottom,
    kLCImageContentModeLeft,
    kLCImageContentModeRight,
    kLCImageContentModeTopLeft,
    kLCImageContentModeTopRight,
    kLCImageContentModeBottomLeft,
    kLCImageContentModeBottomRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface LCImageFactory : NSObject

/**
 *  将图片按照给定的方式裁剪成椭圆形
 *  @param image 想要裁剪的图片
 *  @param size 想要裁剪的大小，如果 size 的宽高一致，则会裁剪成圆形，否则为椭圆形；
 *  @param mode 参考 @c kLCImageContentMode
 */
+ (UIImage *)clipImageAsOval:(UIImage *)image ovalSize:(CGSize)size contentModel:(kLCImageContentMode)mode;


/**
 *  将图片按照给定的方式裁剪成矩形
 *  @param image 想要裁剪的图片
 *  @param size 想要裁剪的大小
 *  @param mode 参考 @c kLCImageContentMode
 */
+ (UIImage *)clipImageAsRect:(UIImage *)image rectSize:(CGSize)size contentModel:(kLCImageContentMode)mode;

/**
 *  将图片按照给定的方式裁剪成圆角矩形
 *  @param image 想要裁剪的图片
 *  @param size 想要裁剪的大小
 *  @param radius 圆角的半径
 *  @param options 圆角的位置 @c kLCImageClipRoundRectOption
 *  @param mode 参考 @c kLCImageContentMode
 */
+ (UIImage *)clipImageAsRoundRect:(UIImage *)image rectSize:(CGSize)size roundRadius:(CGFloat)radius roundRectOptions:(kLCImageClipRoundRectOption)options contentModel:(kLCImageContentMode)mode;

@end

NS_ASSUME_NONNULL_END
