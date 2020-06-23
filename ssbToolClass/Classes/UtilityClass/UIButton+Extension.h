//
//  UIButton+Extension.h
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)

#pragma mark --  设置按钮可点击范围
/**
 *
 * 设置可点击范围到按钮边缘的距离
 *
 */
- (void)setEnlargeEdge:(CGFloat)size;
 
/**
 *
 * 设置可点击范围到按钮上、右、下、左的距离
 *
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

#pragma mark --  快速创建按钮
/**
 快速创建按钮

 @param title 标题
 @param fontName 标题样式
 @param fontSize 标题大小
 @param normalColor 默认颜色
 @param selectedColor 选中颜色
 @return 按钮
 */
+ (instancetype)buttonWithTitleString:(NSString *)title fontName:(nullable NSString *)fontName fontSize:(CGFloat)fontSize normalColor:(NSString *)normalColor selectedColor:(NSString *)selectedColor;

#pragma mark --  快速创建倒计时按钮
/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
