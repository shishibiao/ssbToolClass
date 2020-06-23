//
//  Utility.h
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#ifndef Utility_h
#define Utility_h

/**
 *  判断设备
 */
// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断 iOS 或更高的系统版本
#define IOS_VERSION_6_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)? (YES):(NO))
#define IOS_VERSION_7_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)? (YES):(NO))
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)? (YES):(NO))
#define IOS_VERSION_9_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)? (YES):(NO))
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0)? (YES):(NO))

//StatusBar高度  状态栏
#define Height_StatusBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.0 : 20.0)
//NavBar高度 （导航栏+状态栏）
#define Height_NavBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)
//TabBar高度
#define Height_TabBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.0 : 49.0)
//状态栏
#define kNavBarHeight 44.0
//（导航栏+状态栏）
#define kTopHeight (Height_StatusBar + kNavBarHeight)    //nav

/**
*  获取RGB颜色
*/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/**
*  调试日志
*/
#ifdef DEBUG
#define NSSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSSLog(...)
#endif

#define Search_URL NSLocalizedString(@"SearchURL", nil)

//获取版本号
#define Version  [(__bridge NSDictionary *)CFBundleGetInfoDictionary(CFBundleGetMainBundle())objectForKey:@"CFBundleVersion"]

//获取uid
#define boundleid  [(__bridge NSDictionary *)CFBundleGetInfoDictionary(CFBundleGetMainBundle())objectForKey:@"CFBundleIdentifier"]

//获控制器 高度、宽度
#define VW (self.view.frame.size.width)
#define VH (self.view.frame.size.height)


//获控控件 高度、宽度
#define KW (self.frame.size.width)
#define KH (self.frame.size.height)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define MY_SCREEN ([UIScreen mainScreen].bounds)
#define MY_WIDTH (MY_SCREEN.size.width)
#define MY_HEIGHT (MY_SCREEN.size.height)

#define APPLICATION         [UIApplication sharedApplication]
#define APPDLE              (AppDelegate*)[APPLICATION delegate]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
//获取temp
#define kPathTemp           NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//NSUserDefault缓存
#define SAVEDEFAULTS(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define GETDEFAULTS(key) [[NSUserDefaults standardUserDefaults] objectForKey:key];


#import "NSString+Extension.h"
#import "HelperManage.h"
#import "UIImage+Exension.h" 
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "UIButton+Extension.h"
#import "UILabel+Exension.h"

#endif /* Utility_h */
