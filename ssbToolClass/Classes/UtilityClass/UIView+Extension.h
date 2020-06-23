//
//  UIView+Extension.h
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

- (void)setTapActionWithBlock:(void (^)(void))block;

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;


/**
 *
 * 屏幕截图
 * @param size 屏幕尺寸
 * retrun 返回image
 *
 */
- (UIImage *)screenCapture:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
