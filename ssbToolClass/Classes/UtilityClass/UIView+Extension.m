//
//  UIView+Extension.m
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#import "UIView+Extension.h"
#import<objc/runtime.h>

static char kLAActionHandlerTapGestureKey;
static char kLAActionHandlerTapBlockKey;

@implementation UIView (Extension)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}


- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

- (void)setTapActionWithBlock:(void (^)(void))block {
    // 运行时获取单击对象
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kLAActionHandlerTapGestureKey);
    if (!gesture) {
        // 如果没有该对象，就创建一个
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        // 绑定一下gesture
        objc_setAssociatedObject(self, &kLAActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    // 绑定一下block
    objc_setAssociatedObject(self, &kLAActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        // 取出上面绑定的block
        void(^action)(void) = objc_getAssociatedObject(self, &kLAActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}


- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (UIImage *)screenCapture:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat scale = size.width / self.layer.bounds.size.width;
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    CGContextConcatCTM(ctx, transform);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
