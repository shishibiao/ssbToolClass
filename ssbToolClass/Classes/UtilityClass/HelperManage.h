//
//  HelperManage.h
//  demo11
//
//  Created by apple on 2020/6/22.
//  Copyright © 2020 ssb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelperManage : NSObject

+(HelperManage *)shareHelperManage;

#pragma mark - 获取宽、高
/**
 *
 * 输入字符串、字体、高度，返回宽度
 * retrun  宽度
 * @param  str 字符串
 * @param wordFont 字体
 * @param height 高度
 *
 */
+ (CGFloat)widthForString:(NSString*)str andFont:(UIFont*)wordFont height:(CGFloat)height;

/**
 *
 * 输入字符串、字体、宽度，返回高度
 * retrun  高度
 * @param  str 字符串
 * @param wordFont 字体
 * @param width 高度
 *
 */
+ (CGFloat)hightForString:(NSString *)str andFont:(UIFont*)wordFont width:(CGFloat)width;



#pragma mark - 时间操作

/**
 *  两个时间相隔
 *  @param begintime  开始时间
 *  @param endtime 结束时间
 *  retrun CGFloat
 */
+(CGFloat)begintime:(NSString *)begintime endtime:(NSString *)endtime;

#pragma mark - 各种转换类型
/**
 *
 * 字符串转字典
 * @param jsonString  字符串
 * return NSDictionary
 *
 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *
 * 字典转化字符串
 * @param dic  字典类型
 * return 字符串
 */
+(NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *
 * 字符串转数组
 * @param symbolStr  分隔符
 * return 数组
 */
+(NSArray *)turnString:(NSString *)string andsymbol:(NSString *)symbolStr;

/**
 *
 * 数组转字符串
 * @param symbolStr 分隔符
 * return 字符串
 */
+(NSString *)turnArr:(NSArray *)array andsymbol:(NSString *)symbolStr;


#pragma mark - 判断传入的值
/**
 *
 * 判断字符串是否为空   YES空   NO不空
 * @param aStr  字符串
 */
+(BOOL)isBlankString:(NSString *)aStr;

/**
 *
 * 判断数组为空  YES空   NO不空
 * @param arr 数组
 *
 */
+(BOOL)isBlankArr:(NSArray *)arr;

/**
 *
 * 判断字典为空  YES空   NO不空
 * @param dic 字典
 */
+(BOOL)isBlankDictionary:(NSDictionary *)dic;

#pragma mark - 图片操作
/**
 *
 * 获取本地视频第一帧
 * @param videoURL url
 * retrun 图片
 *
*/
+(UIImage *)getImage:(NSString *)videoURL;

#pragma mark - 改变行间距和字间距
/**
 * 改变行间距和字间距
 */
-(void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end

NS_ASSUME_NONNULL_END
