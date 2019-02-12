//
//  NSMutableAttributedString+SCText.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "NSMutableAttributedString+SCText.h"
#import <objc/runtime.h>
#import "NSParagraphStyle+SCText.h"

static const void *kSCTextLabelFontKey = "kSCTextLabelFontKey";
static const void *kSCTextLabelColorKey = "kSCTextLabelColorKey";
static const void *kSCTextLabelTextAlignmentKey = "kSCTextLabelTextAlignmentKey";
static const void *kSCTextLabelParagraphStyleKey = "kSCTextLabelParagraphStyleKey";
static const void *kSCTextLabelLineBreakModeKey = "kSCTextLabelLineBreakModeKey";

#define ParagraphStyleSet(_property_) \
[self enumerateAttribute:NSParagraphStyleAttributeName \
                 inRange:range \
                 options:kNilOptions \
            usingBlock:^(NSParagraphStyle *value, NSRange subRange, BOOL *stop) { \
                NSMutableParagraphStyle *style = nil; \
                if (value) { \
                    if (CFGetTypeID((__bridge CFTypeRef)(value)) == CTParagraphStyleGetTypeID()) { \
                        value = [NSParagraphStyle sc_styleWithCTStyle:(__bridge CTParagraphStyleRef)(value)]; \
                    } \
                    if (value._property_ == _property_) { \
                        return; \
                    } \
                    if ([value isKindOfClass:[NSMutableParagraphStyle class]]) { \
                        style = (id)value; \
                    } else { \
                        style = value.mutableCopy; \
                    } \
                } else { \
                    if (NSParagraphStyle.defaultParagraphStyle._property_ == _property_) { \
                        return; \
                    } \
                    style = NSParagraphStyle.defaultParagraphStyle.mutableCopy; \
                } \
                style._property_ = _property_; \
                [self sc_setParagraphStyle:style range:subRange]; \
            }];

@implementation NSMutableAttributedString (SCText)

#pragma mark - Public Functions

- (void)sc_setFont:(UIFont *)font range:(NSRange)range {
    [self sc_setAttribute:NSFontAttributeName value:font range:range];
}

- (void)sc_setColor:(UIColor *)color range:(NSRange)range {
    [self sc_setAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)sc_setParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    [self sc_setAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

- (void)sc_setAlignment:(NSTextAlignment)alignment range:(NSRange)range {
    ParagraphStyleSet(alignment);
}

- (void)sc_setLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range {
    ParagraphStyleSet(lineBreakMode);
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

- (NSTextAlignment)sc_alignment {
    return (NSTextAlignment)[objc_getAssociatedObject(self, kSCTextLabelTextAlignmentKey) integerValue];
}

- (void)setSc_alignment:(NSTextAlignment)sc_alignment {
    objc_setAssociatedObject(self, kSCTextLabelTextAlignmentKey, @(sc_alignment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sc_setAlignment:sc_alignment range:[self allAttributeTextRange]];
}

- (NSParagraphStyle *)sc_paragraphStyle {
    return objc_getAssociatedObject(self, kSCTextLabelParagraphStyleKey);
}

- (void)setSc_paragraphStyle:(NSParagraphStyle *)sc_paragraphStyle {
    objc_setAssociatedObject(self, kSCTextLabelParagraphStyleKey, sc_paragraphStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sc_setParagraphStyle:sc_paragraphStyle range:[self allAttributeTextRange]];
}

- (NSLineBreakMode)sc_lineBreakMode {
    return (NSLineBreakMode)[objc_getAssociatedObject(self, kSCTextLabelLineBreakModeKey) integerValue];
}

- (void)setSc_lineBreakMode:(NSLineBreakMode)sc_lineBreakMode {
    objc_setAssociatedObject(self, kSCTextLabelLineBreakModeKey, @(sc_lineBreakMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sc_setLineBreakMode:sc_lineBreakMode range:[self allAttributeTextRange]];
}

@end
