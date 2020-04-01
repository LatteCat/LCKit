//
//  LCImageFactory.m
//  LCKit
//
//  Created by lattecat on 2020/4/1.
//

#import "LCImageFactory.h"
#import "LCKitMacro.h"

@implementation LCImageFactory

+ (UIImage *)clipImageAsOval:(UIImage *)image ovalSize:(CGSize)size contentModel:(kLCImageContentMode)mode {
    UIImage *clipedImage = [self clipImage:image size:size contentModel:mode coustomBlock:^(CGContextRef ctx) {
        // 裁剪成椭圆形
        CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, size.width, size.height));
        CGContextClip(ctx);
    }];
    
    return clipedImage;
}

+ (UIImage *)clipImageAsRect:(UIImage *)image rectSize:(CGSize)size contentModel:(kLCImageContentMode)mode {
    return [self clipImageAsRoundRect:image rectSize:size roundRadius:0.0 roundRectOptions:kLCImageClipRoundRectOptionNone contentModel:mode];
}

+ (UIImage *)clipImageAsRoundRect:(UIImage *)image rectSize:(CGSize)size roundRadius:(CGFloat)radius roundRectOptions:(kLCImageClipRoundRectOption)options contentModel:(kLCImageContentMode)mode {
    if (radius <= 0.0) {
        options = kLCImageClipRoundRectOptionNone;
    }
    UIImage *clipedImage = [self clipImage:image size:size contentModel:mode coustomBlock:^(CGContextRef ctx) {
        CGContextMoveToPoint(ctx, 0.0, radius);
        
        // 绘制左上角
        if (options & kLCImageClipRoundRectOptionTopLeft) {
            CGContextAddArcToPoint(ctx, 0.0, 0.0, radius, 0.0, radius);
        } else {
            CGContextAddLineToPoint(ctx, 0.0, 0.0);
        }
        
        // 绘制右上角
        if (options & kLCImageClipRoundRectOptionTopRight) {
            CGContextAddLineToPoint(ctx, size.width - radius, 0.0);
            CGContextAddArcToPoint(ctx, size.width, 0.0, size.width, radius, radius);
        } else {
            CGContextAddLineToPoint(ctx, size.width, 0.0);
            CGContextAddLineToPoint(ctx, size.width, radius);
        }
        
        // 绘制右下角
        if (options & kLCImageClipRoundRectOptionBottonRight) {
            CGContextAddLineToPoint(ctx, size.width, size.height - radius);
            CGContextAddArcToPoint(ctx, size.width, size.height, size.width - radius, size.height, radius);
        } else {
            CGContextAddLineToPoint(ctx, size.width, size.height);
            CGContextAddLineToPoint(ctx, size.width - radius, size.height);
        }
        
        // 绘制左下角
        if (options & kLCImageClipRoundRectOptionBottomLeft) {
            CGContextAddLineToPoint(ctx, radius, size.height);
            CGContextAddArcToPoint(ctx, 0.0, size.height, 0.0, size.height - radius, radius);
        } else {
            CGContextAddLineToPoint(ctx, 0.0, size.height);
        }
        CGContextAddLineToPoint(ctx, 0.0, radius);
        
        CGContextClip(ctx);
    }];
    
    return clipedImage;
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Helper
//***********************************************************************************************************************************************************

/**
 *  裁剪图片
 */
+ (UIImage *)clipImage:(UIImage *)image size:(CGSize)size contentModel:(kLCImageContentMode)mode coustomBlock:(void (^)(CGContextRef ctx))block {
    CGSize imageSize = CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
    CGRect drawRect = [self drawRectWithSourceSize:imageSize targetSize:size contentModel:mode];
    UIImage *clipedImage = nil;
    
    // 绘制图片
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    
    // 调用自定义的裁剪方法
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    PERFORM_SAFE_BLOCK(block, ctx);
    
    [image drawInRect:drawRect];
    clipedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return clipedImage;
}

/**
 *  获取图片的绘制区域
 */
+ (CGRect)drawRectWithSourceSize:(CGSize)srcSize targetSize:(CGSize)targetSize contentModel:(kLCImageContentMode)mode {
    CGRect drawRect;
    switch (mode) {
        case kLCImageContentModeScaleToFill: {
            drawRect = CGRectMake(0.0,
                                  0.0,
                                  targetSize.width,
                                  targetSize.height);
            break;
        }
        case kLCImageContentModeAspectFit: {
            if (srcSize.width / srcSize.height > targetSize.width / targetSize.height) {
                // 图片垂直居中：三
                CGFloat width = targetSize.width;
                CGFloat height = width * srcSize.height / srcSize.width;
                drawRect = CGRectMake(0.0,
                                      (targetSize.height - height) * 0.5,
                                      width,
                                      height);
            } else {
                // 图片横向居中：川
                CGFloat height = targetSize.height;
                CGFloat width = height * srcSize.width / srcSize.height;
                drawRect = CGRectMake((targetSize.width - width) * 0.5,
                                      0.0,
                                      width,
                                      height);
            }
            break;
        }
        case kLCImageContentModeAspectFill: {
            if (srcSize.width / srcSize.height > targetSize.width / targetSize.height) {
                // 裁剪框横向居中：川
                CGFloat height = targetSize.height;
                CGFloat width = height * srcSize.width / srcSize.height;
                drawRect = CGRectMake((targetSize.width - width) * 0.5,
                                      0.0,
                                      width,
                                      height);
            } else {
                CGFloat width = targetSize.width;
                CGFloat height = width * srcSize.height / srcSize.width;
                drawRect = CGRectMake(0.0,
                                      (targetSize.height - height) * 0.5,
                                      width,
                                      height);
            }
            break;
        }
        case kLCImageContentModeCenter: {
            drawRect = CGRectMake((targetSize.width - srcSize.width) * 0.5,
                                  (targetSize.height - srcSize.height) * 0.5,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeTop: {
            drawRect = CGRectMake((targetSize.width - srcSize.width) * 0.5,
                                  0.0,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeBottom: {
            drawRect = CGRectMake((targetSize.width - srcSize.width) * 0.5,
                                  targetSize.height - srcSize.height,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeLeft: {
            drawRect = CGRectMake(0.0,
                                  (targetSize.height - srcSize.height) * 0.5,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeRight: {
            drawRect = CGRectMake(targetSize.width - srcSize.width,
                                  (targetSize.height - srcSize.height) * 0.5,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeTopLeft: {
            drawRect = CGRectMake(0.0,
                                  0.0,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeTopRight: {
            drawRect = CGRectMake(targetSize.width - srcSize.width,
                                  0.0,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeBottomLeft: {
            drawRect = CGRectMake(0.0,
                                  targetSize.height - srcSize.height,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
        case kLCImageContentModeBottomRight: {
            drawRect = CGRectMake(targetSize.width - srcSize.width,
                                  targetSize.height - srcSize.height,
                                  srcSize.width,
                                  srcSize.height);
            break;
        }
    }
    return drawRect;
}

@end
