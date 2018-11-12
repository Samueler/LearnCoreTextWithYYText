//
//  NSMutableAttributedString+SCText.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "NSMutableAttributedString+SCText.h"
#import <objc/runtime.h>

static const void *kSCTextLabelFontKey = "kSCTextLabelFontKey";
static const void *kSCTextLabelColorKey = "kSCTextLabelColorKey";

@implementation NSMutableAttributedString (SCText)

#pragma mark - Public Functions

- (void)sc_setFont:(UIFont *)font range:(NSRange)range {
    [self sc_setAttribute:NSFontAttributeName value:font range:range];
}

- (void)sc_setColor:(UIColor *)color range:(NSRange)range {
    [self sc_setAttribute:NSForegroundColorAttributeName value:color range:range];
}

#pragma mark - Private Functions

- (void)sc_setAttribute:(NSString *)name value:(id)value {
    [self sc_setAttribute:name value:value range:[self allAttributeTextRange]];
}

- (void)sc_setAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if (!name || [NSNull isEqual:name]) {
        return;
    }
    
    if (value && ![NSNull isEqual:name]) {
        [self addAttribute:name value:value range:range];
    } else {
        [self removeAttribute:name range:range];
    }
}

- (NSRange)allAttributeTextRange {
    return NSMakeRange(0, self.length);
}

#pragma mark - Getter && Setter

- (UIFont *)sc_font {
    return objc_getAssociatedObject(self, kSCTextLabelFontKey);
}

- (void)setSc_font:(UIFont *)sc_font {
    objc_setAssociatedObject(self, kSCTextLabelFontKey, sc_font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sc_setFont:sc_font range:[self allAttributeTextRange]];
}

- (UIColor *)sc_color {
    return objc_getAssociatedObject(self, kSCTextLabelColorKey);
}

- (void)setSc_color:(UIColor *)sc_color {
    objc_setAssociatedObject(self, kSCTextLabelColorKey, sc_color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sc_setColor:sc_color range:[self allAttributeTextRange]];
}




@end
