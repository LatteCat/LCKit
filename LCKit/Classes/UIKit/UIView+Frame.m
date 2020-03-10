//
//  UIView+Frame.m
//  LCKit
//
//  Created by lattecat on 2020/3/10.
//

#import "UIView+Frame.h"

CGFloat UIEdgeInsetsHorizontal(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

CGFloat UIEdgeInsetsVertical(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}


@implementation UIView (Frame)

- (void)setLc_x:(CGFloat)lc_x {
    CGPoint origin = CGPointMake(lc_x, self.lc_y);
    self.lc_origin = origin;
}

- (CGFloat)lc_x {
    return self.frame.origin.x;
}

- (void)setLc_y:(CGFloat)lc_y {
    CGPoint origin = CGPointMake(self.lc_x, lc_y);
    self.lc_origin = origin;
}

- (CGFloat)lc_y {
    return self.frame.origin.y;
}

- (void)setLc_width:(CGFloat)lc_width {
    CGSize size = CGSizeMake(lc_width, self.lc_height);
    self.lc_size = size;
}

- (CGFloat)lc_width {
    return self.frame.size.width;
}

- (void)setLc_height:(CGFloat)lc_height {
    CGSize size = CGSizeMake(self.lc_width, lc_height);
    self.lc_size = size;
}

- (CGFloat)lc_height {
    return self.frame.size.height;
}

- (void)setLc_origin:(CGPoint)lc_origin {
    CGRect tmpRect = self.frame;
    tmpRect.origin = lc_origin;
    self.frame = tmpRect;
}

- (CGPoint)lc_origin {
    return self.frame.origin;
}

- (void)setLc_size:(CGSize)lc_size {
    CGRect tmpRect = self.frame;
    tmpRect.size = lc_size;
    self.frame = tmpRect;
}

- (CGSize)lc_size {
    return self.frame.size;
}

- (void)setLc_trailing:(CGFloat)lc_trailing {
    self.lc_x = lc_trailing - self.lc_width;
}

- (CGFloat)lc_trailing {
    return self.lc_x + self.lc_width;
}

- (void)setLc_bottom:(CGFloat)lc_bottom {
    self.lc_y = lc_bottom - self.lc_height;
}

- (CGFloat)lc_bottom {
    return self.lc_y + self.lc_height;
}

@end
