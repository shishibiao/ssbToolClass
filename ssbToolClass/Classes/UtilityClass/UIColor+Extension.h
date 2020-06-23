//
//  UIColor+Extension.h
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;
- (NSString *)HEXString;

@end

NS_ASSUME_NONNULL_END
