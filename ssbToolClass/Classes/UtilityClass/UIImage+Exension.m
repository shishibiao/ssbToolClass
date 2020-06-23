//
//  UIImage+Exension.m
//  demo11
//
//  Created by apple on 2020/6/22.
//  Copyright © 2020 ssb. All rights reserved.
//

#import "UIImage+Exension.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Exension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

/**
 生成一张高斯模糊的图片
*/
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur
{
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    if (inBitmapData) {
        inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    }

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);

    return returnImage;
}


/**
 根据颜色生成一张图片
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        // 开启图形上下文
        UIGraphicsBeginImageContext(rect.size);
        // 获取当前的上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 将颜色填充到上下文
        CGContextSetFillColorWithColor(context, color.CGColor);
        // 将内容填满指定的尺寸
        CGContextFillRect(context, rect);
        // 从上下文获取图片
        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        return image;
    }
    return nil;
}


/**
 生成一张圆形图片
*/
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    // 设置圆形图片的直径
    CGFloat imageDia = originImage.size.width;
    // 计算外圆的直径(边框是在图片外额外添加的区域)
    CGFloat borderDia = imageDia + 2 * borderWidth;

    // 开启图形上下文
    UIGraphicsBeginImageContext(originImage.size);
    // 画一个包含边框的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, borderDia, borderDia)];
    // 设置颜色
    [borderColor set];
    [path fill];

    // 设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageDia, imageDia)];
    // 裁剪图片
    [clipPath addClip];
    
    // 绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    // 从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
}


/**
 生成一张不被渲染的图片
*/
+ (UIImage *)imageRenderingModeAlowsOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)cropImageWithSize:(CGSize)size {
    
    float scale = self.size.width/self.size.height;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height) {
        
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
        
    }else {
        
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
        
    }
    
    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}




/**
 *  加水印
 */
- (UIImage *)waterWithText:(NSString *)text direction:(ImageWaterDirect)direction fontColor:(UIColor *)fontColor fontPoint:(CGFloat)fontPoint marginXY:(CGPoint)marginXY {
    CGSize size = self.size;
    CGRect rect = (CGRect){CGPointZero, size};
    //新建图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    //绘制图片
    [self drawInRect:rect];
    //绘制文本
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontPoint], NSForegroundColorAttributeName : fontColor};
    CGRect strRect = [self calWidth:text attr:attr direction:direction rect:rect marginXY:marginXY];
    [text drawInRect:strRect withAttributes:attr];
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束图片图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGRect)calWidth:(NSString *)str attr:(NSDictionary *)attr direction:(ImageWaterDirect)direction rect:(CGRect)rect marginXY:(CGPoint)marginXY {
    CGSize size = [str sizeWithAttributes:attr];
    CGRect calRect = [self rectWithRect:rect size:size direction:direction marginXY:marginXY];
    return calRect;
}

- (CGRect)rectWithRect:(CGRect)rect size:(CGSize)size direction:(ImageWaterDirect)direction marginXY:(CGPoint)marginXY {
    CGPoint point = CGPointZero;
    //右上
    if (ImageWaterDirectTopRight == direction) point = CGPointMake(rect.size.width - size.width, 0);
    //左下
    if (ImageWaterDirectBottomLeft == direction) point = CGPointMake(0, rect.size.height - size.height);
    //右下
    if (ImageWaterDirectBottomRight == direction) point = CGPointMake(rect.size.width - size.width, rect.size.height - size.height);
    //正中
    if (ImageWaterDirectCenter == direction) point = CGPointMake((rect.size.width - size.width) * .5f, (rect.size.height - size.height) * .5f);
    point.x += marginXY.x;
    point.y += marginXY.y;
    CGRect calRect = (CGRect){point, size};
    return calRect;
}

/**
 *  加水印
 */
- (UIImage *)waterWithWaterImage:(UIImage *)waterImage direction:(ImageWaterDirect)direction waterSize:(CGSize)waterSize marginXY:(CGPoint)marginXY {
    CGSize size = self.size;
    CGRect rect = (CGRect){CGPointZero, size};
    //新建图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    //绘制图片
    [self drawInRect:rect];
    //计算水印的rect
    CGSize waterImageSize = CGSizeEqualToSize(waterSize, CGSizeZero) ? waterImage.size : waterSize;
    CGRect calRect = [self rectWithRect:rect size:waterImageSize direction:direction marginXY:marginXY];
    //绘制水印图片
    [waterImage drawInRect:calRect];
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束图片图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
