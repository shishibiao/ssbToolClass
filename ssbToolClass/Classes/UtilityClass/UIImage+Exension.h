//
//  UIImage+Exension.h
//  demo11
//
//  Created by apple on 2020/6/22.
//  Copyright © 2020 ssb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Exension)

/**

给图片加颜色

@param color 颜色
@return 加颜色的图片
*/
+ (UIImage *)imageWithColor:(UIColor *)color;

/**

 生成一张高斯模糊的图片

 @param image 原图
 @param blur 模糊程度
 @return 高斯模糊的图片
 */
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 根据颜色生成一张图片

 @param color 颜色
 @param size 要生成图片的尺寸
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 生成一张圆形图片

 @param originImage 原始图片
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 生成一张不被渲染的图片

 @param imageName 图片名称
 @return 不会被渲染的原始图片
 */
+ (UIImage *)imageRenderingModeAlowsOriginal:(NSString *)imageName;


/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)cropImageWithSize:(CGSize)size;

#pragma mark - function😇
/**
 *  水印方向
 */
typedef NS_ENUM(NSInteger, ImageWaterDirect) {
    //左上
    ImageWaterDirectTopLeft = 0,
    //右上
    ImageWaterDirectTopRight,
    //左下
    ImageWaterDirectBottomLeft,
    //右下
    ImageWaterDirectBottomRight,
    //正中
    ImageWaterDirectCenter
    
};

/**
 *  加水印
 */
- (UIImage *)waterWithText:(NSString *)text direction:(ImageWaterDirect)direction fontColor:(UIColor *)fontColor fontPoint:(CGFloat)fontPoint marginXY:(CGPoint)marginXY;

/**
 *  加水印
 */
- (UIImage *)waterWithWaterImage:(UIImage *)waterImage direction:(ImageWaterDirect)direction waterSize:(CGSize)waterSize marginXY:(CGPoint)marginXY;

- (UIImage *)fixOrientation;

@end

NS_ASSUME_NONNULL_END
