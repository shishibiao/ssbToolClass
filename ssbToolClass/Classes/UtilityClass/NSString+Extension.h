//
//  NSString+Extension.h
//  
//
//  Created by apple on 2020/6/22.
//  Copyright © 2020 ssb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 时间戳枚举
 * GetTimeString_Point_Second  yyyy.MM.dd HH:mm:ss
 * GetTimeString_Cross_Seconds  yyyy-MM-dd HH:mm:ss
 * GetTimeString_Text  yyyy年MM月dd日
 * GetTimeString_Point_NoSecond  yyyy.MM.dd
 * GetTimeString_Cross_NoSecond  yyyy-MM-dd
 *
 */
typedef NS_ENUM(NSUInteger,GetTimeString){
    GetTimeString_Point_Second = 0,
    GetTimeString_Cross_Seconds = 1,
    GetTimeString_Text = 2,
    GetTimeString_Point_NoSecond = 3,
    GetTimeString_Cross_NoSecond = 4,
};

@interface NSString (Extension)

#pragma mark - 时间类

/**
 *
 * 获取时间戳
 * retrun 时间戳
 *
 */
+(NSString *)getNowTimeTimestamp;

/**
 *
 * 时间戳枚举
 * ----GetTimeString_Point_Second  yyyy.MM.dd HH:mm:ss
 * ----GetTimeString_Cross_Seconds  yyyy-MM-dd HH:mm:ss
 * ----GetTimeString_Text  yyyy年MM月dd日
 * ----GetTimeString_Point_NoSecond  yyyy.MM.dd
 * ----GetTimeString_Cross_NoSecond  yyyy-MM-dd
 * @param timeString  时间戳
 */
+(NSString *)timeWithTimeIntervalString:(GetTimeString)getTimeString timeString:(NSString *)timeString;

/**
 *
 * 判断是否为今天、昨天、明天
 * @param string  传入的时间戳
 */
+(NSString *)compareDate:(NSString *)string;

/**
 *
 * 和当前时间比较
 * 1）1分钟以内 显示        :    刚刚
 * 2）1小时以内 显示        :    X分钟前
 * 3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 * 4)  今年显示              :   09月12日
 * 5)  大于本年      显示    :    2013/09/09
 * @param dateString  当前时间
 * @param formate  时间模式     如： yyyy-MM-dd HH:mm:ss
 * retrun 字符串
 */
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *)formate;


#pragma mark -对一个字符串进行base64编码或解码
/**
 *
 * base64编码
 * @param string
 * retrun 编码后的字符串
 */
+(NSString *)base64EncodeString:(NSString *)string;


/**
 *
 * base64解码
 * @param string
 * retrun 解码后的字符串
 *
*/
+(NSString *)base64DecodeString:(NSString *)string;

/**
 *
 * 编码字符串
 * @param uncodeString  需要编码的字符串
 * retrun 编码后的字符串
 */
+(NSString*)encodeString:(NSString*)uncodeString;


/**
 * 解码
 * @param decodeString 需要解码的字符串
 * retrun 解码后的字符串
 */
+(NSString*)decodeString:(NSString*)decodeString;

#pragma mark - 匹配

- (BOOL)isMatchString:(NSString *)pattern;

/**
 *
 * 是否是域名
 *
 */
-(BOOL)isDomain;

/**
 *
 * 是否是网址
 *
 */
- (BOOL)isHttpURL;





#pragma mark - 散列函数
/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)sha1String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)sha256String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (NSString *)sha512String;

#pragma mark - HMAC 散列函数
/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 文件散列函数

/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)fileMD5Hash;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)fileSHA1Hash;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)fileSHA256Hash;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)fileSHA512Hash;

#pragma mark - 获取本地目录
/// 获取Documents目录
+ (NSString *)getDocumentsPath;
/// 获取Cache目录
+ (NSString *)getCachePath;
/// 获取tmp目录
+ (NSString *)getTempPath;

#pragma mark -- 根据url的最后一部分,来命名保存该url内容的路径
/// 保存在Documents目录下
- (NSString *)appendDocumentsPath;
/// 保存在Cache目录下
- (NSString *)appendCachePath;
/// 保存在Tmp目录下
- (NSString *)appendTempPath;

#pragma mark -- 字符
/** 是否中文 */
- (BOOL)isChinese;

/** 计算字符串长度 1个中文算2 个字符 */
- (int)textLength;

/** 验证邮箱是否合法 */
- (BOOL)validateEmail;

/** 验证手机号码合法性 */
- (BOOL)checkPhoneNumInput;

// 验证是否是数字
- (BOOL)isNumber;

/** 验证字符串里面是否都是数字*/
- (BOOL)isPureNumber;
@end

NS_ASSUME_NONNULL_END
