//
//  UIView+Frame.h
//  LCKit
//
//  Created by lattecat on 2020/3/10.
//

#import <UIKit/UIKit.h>

/**
 *  获取 UIEdgeInsets 在水平方向的间距和
 */
FOUNDATION_EXTERN CGFloat UIEdgeInsetsHorizontal(UIEdgeInsets insets);


/**
 *  获取 UIEdgeInsets 在垂直方向的间距和
 */
FOUNDATION_EXTERN CGFloat UIEdgeInsetsVertical(UIEdgeInsets insets);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat                   lc_x;

@property (nonatomic, assign) CGFloat                   lc_y;

@property (nonatomic, assign) CGFloat                   lc_width;

@property (nonatomic, assign) CGFloat                   lc_height;

@property (nonatomic, assign) CGPoint                   lc_origin;

@property (nonatomic, assign) CGSize                    lc_size;

/**
 *  setter 方法不改变 UIView 的大小，只会将其右边界移动到设置的位置；getter 方法返回右边界的位置
 *  @warning    setter 方法会改变 @c lc_x 的值，但是不会改变 @c lc_width 的值；
 *              如果想保留 @c lc_x 的值，并且将右边界移动到对应的位置，请赋值给 @c lc_width
 */
@property (nonatomic, assign) CGFloat                   lc_trailing;

/**
 *  setter 方法不改变 UIView 的大小，只会将其下边界移动到设置的位置；getter 方法返回下边界的位置
 *  @warning    setter 方法会改变 @c lc_y 的值，但是不会改变 @c lc_height 的值；
 *              如果想保留 @c lc_y 的值，并将下边界移动到对应的位置，请赋值给 @c lc_height
 */
@property (nonatomic, assign) CGFloat                   lc_bottom;

@end

NS_ASSUME_NONNULL_END
