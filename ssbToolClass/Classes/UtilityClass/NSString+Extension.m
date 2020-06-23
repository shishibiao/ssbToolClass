//
//  NSString+Extension.m
//  
//
//  Created by apple on 2020/6/22.
//  Copyright © 2020 ssb. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (Extension)



+(NSString *)getNowTimeTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型;
    return timeString;
}

+(NSString *)timeWithTimeIntervalString:(GetTimeString)getTimeString timeString:(NSString *)timeString{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    switch (getTimeString) {
        case GetTimeString_Point_Second:
            [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
            break;
        case GetTimeString_Cross_Seconds:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case GetTimeString_Cross_NoSecond:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case GetTimeString_Point_NoSecond:
            [formatter setDateFormat:@"yyyy.MM.dd"];
            break;
        case GetTimeString_Text:
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            break;
        default:
            break;
    }
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+(NSString *)compareDate:(NSString *)string{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSDate *date = [format dateFromString:string];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];

    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString]) {
        return @"今天";
    }else if ([dateString isEqualToString:yesterdayString]){
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString]){
        return @"明天";
    }else{
        return dateString;
    }
}


+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        //将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        //取当前时间和转换时间两个日期对象的时间间隔
        //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        //再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        if (time<=60) {  //1分钟以内的
            dateStr = @"刚刚";
        }else if (time<=60*60){  //一个小时以内的
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        }else if (time<=60*60*24){ //在两天内的
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                //昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else{
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            if ([yearStr isEqualToString:nowYear]) {  //在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        return dateStr;
    } @catch (NSException *exception) {
        return @"";
    }
}


+(NSString *)base64EncodeString:(NSString *)string{
    //1、先转换成二进制数据
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}


+(NSString *)base64DecodeString:(NSString *)string{
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:string options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//编码
+(NSString*)encodeString:(NSString*)uncodeString
{
    return (NSString *)CFBridgingRelease((__bridge CFTypeRef _Nullable)([[uncodeString description] stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet]]));
}
//解码
+(NSString*)decodeString:(NSString*)decodeString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)decodeString, CFSTR("")));
}

- (BOOL)isMatchString:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return NO;
    }
    NSTextCheckingResult *res = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return res != nil;
}

//是否是域名
- (BOOL)isDomain{
    return [self isMatchString:@"^([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}$"]
    || [self isMatchString:@"^(www.|[a-zA-Z].)[a-zA-Z0-9\\-\\.]+\\.(com|edu|gov|mil|net|org|biz|info|name|museum|us|ca|uk)(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\;\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"];
}

- (BOOL)isHttpURL{
    return [self isMatchString:@"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?"]
    || [self isMatchString:@"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.[a-zA-Z]{2,4})(\\:[0-9]+)?(/[^/][a-zA-Z0-9\\.\\,\\?\\'\\\\/\\+&amp;%\\$#\\=~_\\-@]*)*$"]
    || [self isMatchString:@"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"];
}



#pragma mark - 散列函数
- (NSString *)md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC 散列函数
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 文件散列函数

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 助手方法
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}



+ (NSString *)getDocumentsPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getTempPath
{
    return NSTemporaryDirectory();
}

/// 获取Documents目录
- (NSString *)appendDocumentsPath
{
    // 获取Documents文件目录
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 获取图片的名字
    NSString *fileName = [self lastPathComponent];
    // Documents文件目录拼接图片的名字 == 图片保存到沙盒的路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

/// 获取Cache目录
- (NSString *)appendCachePath
{
    // 获取Cache文件目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 获取图片的名字
    NSString *fileName = [self lastPathComponent];
    // Cache文件目录拼接图片的名字 == 图片保存到沙盒的路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

/// 获取Tmp目录
- (NSString *)appendTempPath
{
    // 获取Documents文件目录
    NSString *tmpPath = NSTemporaryDirectory();
    // 获取图片的名字
    NSString *fileName = [self lastPathComponent];
    // Documents文件目录拼接图片的名字 == 图片保存到沙盒的路径
    NSString *filePath = [tmpPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

//是否中文
- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
//计算字符串长度 1中文2字符
- (int)textLength {
    float number = 0.0;
    for (int index = 0; index < [self length]; index++) {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number = number + 2;
        } else {
            number = number + 1;
        }
    }
    return ceil(number);
}

//邮箱格式验证
- (BOOL)validateEmail {
    NSString *emailRegex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//手机号格式验证
- (BOOL)checkPhoneNumInput {
    NSString *Phoneend = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([Phoneend hasPrefix:@"1"] && Phoneend.textLength == 11) {
        return YES;
    }
    return NO;
}

// 验证是否是数字
- (BOOL)isNumber {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

// 验证字符串里面是否都是数字
- (BOOL)isPureNumber {
    NSUInteger length = [self length];
    for (float i = 0; i < length; i++) {
        // NSString * c=[mytimestr characterAtIndex:i];
        NSString *STR = [self substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", STR);
        if ([STR isNumber]) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

@end
