//
//  UIButton+Extension.m
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIColor+Extension.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (Extension)

- (void)setEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}
 
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}


+ (instancetype)buttonWithTitleString:(NSString *)title fontName:(nullable NSString *)fontName fontSize:(CGFloat)fontSize normalColor:(NSString *)normalColor selectedColor:(NSString *)selectedColor{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:normalColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:selectedColor] forState:UIControlStateSelected];
    
    if(fontName){
        [button.titleLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    }else{
        [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    }
    [button sizeToFit];
    
    return button;
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {

    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{

        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);

            dispatch_async(dispatch_get_main_queue(), ^{

                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });

        } else {

            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@", timeStr, subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });

            timeOut--;
        }
    });

    dispatch_resume(_timer);
}

@end
