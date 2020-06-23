//
//  HelperManage.m
//  demo11
//
//  Created by apple on 2020/6/22.
//  Copyright © 2020 ssb. All rights reserved.
//

#import "HelperManage.h"

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

static HelperManage *helperManage;

@implementation HelperManage

+(HelperManage *)shareHelperManage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helperManage = [[HelperManage alloc]init];
    });
    return helperManage;
}

+ (CGFloat)widthForString:(NSString*)str andFont:(UIFont*)wordFont height:(CGFloat)height{
    if (str == nil) {
        return 0;
    }
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:wordFont,NSFontAttributeName,nil];//字体属性，设置字体的font
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);     //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size; return ceil(size.width);     //此方法结合  预编译字符串  字体font  字符串宽高  三个参数计算文本  返回字符串宽度
    return size.width;
}

+ (CGFloat)hightForString:(NSString *)str andFont:(UIFont*)wordFont width:(CGFloat)width{
    if (str == nil) {
        return 0;
    }
    NSDictionary *arrtibute = @{NSFontAttributeName:wordFont};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:arrtibute context:nil].size;
    return size.height;
}


+(CGFloat)begintime:(NSString *)begintime endtime:(NSString *)endtime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[begintime doubleValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endtime doubleValue]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:date2 options:0];
    if (cmps.minute> 0 ) {
        return cmps.minute * 60 + cmps.second;
    }else if (cmps.minute == 0 && cmps.second > 0){
        return cmps.second;
    }else if (cmps.minute == 0 && cmps.second == 0){
        return 0;
    }
    return 0;
}

//字符串转字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return @{@"msg":@"Json解析失败"};
    }
    return dic;
}

+(NSString*) dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSArray *)turnString:(NSString *)string andsymbol:(NSString *)symbolStr{
    NSArray  *array = [string componentsSeparatedByString:symbolStr];
    return array;
}

+(NSString *)turnArr:(NSArray *)array andsymbol:(NSString *)symbolStr{
    NSString *str = [array componentsJoinedByString:symbolStr];
    return str;
}


+(BOOL)isBlankString:(NSString *)aStr {
    if ( !aStr ) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *Set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedstr = [aStr stringByTrimmingCharactersInSet:Set];
    if (!trimmedstr.length) {
        return YES;
    }
    if (aStr == nil) {
        return YES;
    }
    if (aStr == NULL) {
        return YES;
    }
    if ([aStr isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([aStr isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([aStr isEqualToString:@"NULL"]) {
        return YES;
    }
    return NO;
}

+(BOOL)isBlankArr:(NSArray *)arr {
    if (!arr) {
        return YES;
    }
    if ([arr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![arr isKindOfClass:[NSArray class]]) {
        return YES;
    }
    if (!arr.count) {
        return YES;
    }
    if (arr == nil) {
        return YES;
    }
    
    if (arr == NULL) {
        return YES;
    }
        return NO;
}

+(BOOL)isBlankDictionary:(NSDictionary *)dic {
    if (!dic) {
        return YES;
    }
    if ([dic isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (!dic.count) {
        return YES;
    }
    if (dic == nil) {
        return YES;
    }
    if (dic == NULL) {
        return YES;
    }
        return NO;
}

+(UIImage *)getImage:(NSString *)videoURL{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

-(void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

@end
