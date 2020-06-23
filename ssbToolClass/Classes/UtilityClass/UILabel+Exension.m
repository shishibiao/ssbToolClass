//
//  UILabel+Exension.m
//  demo11
//
//  Created by apple on 2020/6/23.
//  Copyright © 2020 ssb. All rights reserved.
//

#import "UILabel+Exension.h"
#import "UIColor+Extension.h"

@implementation UILabel (Exension)

+ (instancetype)labelWithText:(NSString *)text fontName:(nullable NSString *)fontName fontSize:(CGFloat)fontSize colorString:(NSString *)colorString {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    if(fontName){
        label.font = [UIFont fontWithName:fontName size:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textColor = [UIColor colorWithHexString:colorString];
    label.numberOfLines = 0;
    
    return label;
}


@end
