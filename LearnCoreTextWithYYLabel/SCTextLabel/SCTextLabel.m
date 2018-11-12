//
//  SCTextLabel.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "SCTextLabel.h"
#import "SCTextLayer.h"
#import "SCTextLayout.h"
#import "NSMutableAttributedString+SCText.h"

@interface SCTextLabel () <SCTextLayerDelegate> {
    NSMutableAttributedString *_innerAttributeString;
    CGRect _innerFrame;
}

@end

@implementation SCTextLabel

#pragma mark - Override Functions

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _innerFrame = frame;
        
        [self sc_initTextLabel];
    }
    return self;
}

+ (Class)layerClass {
    return [SCTextLayer class];
}

#pragma mark - Private Functions

- (void)sc_setNeedsDisplay {
    [self.layer setNeedsDisplay];
}

- (void)sc_initTextLabel {
    
    self.contentMode = UIViewContentModeRedraw;
    
    _color = [self sc_defaultColor];
    _font = [self sc_defaultFont];
    
    _innerAttributeString = [[NSMutableAttributedString alloc] init];
}

- (UIColor *)sc_defaultColor {
    return [UIColor blackColor];
}

- (UIFont *)sc_defaultFont {
    return [UIFont systemFontOfSize:15.f];
}

#pragma mark - SCTextLayerDelegate

- (void)sc_textLayerDisplay {
    
    NSAttributedString *renderAttributeString = _innerAttributeString.copy;
    CGRect renderRect = _innerFrame;
    
    SCTextLayer *textLayer = (SCTextLayer *)self.layer;
    
    textLayer.textLayerDisplaying = ^(CGContextRef context, CGSize size) {
        SCTextLayout *layout = [SCTextLayout sc_textLayoutWithContext:context attributeText:renderAttributeString];
        [layout sc_textLayoutDrawWithContext:context containerRect:renderRect];
    };
}

#pragma mark - Setter

- (void)setText:(NSString *)text {
    if (_text == text || [_text isEqualToString:text]) {
        return;
    }
    
    BOOL needAddAttributes = !_innerAttributeString.length && text.length;
    [_innerAttributeString replaceCharactersInRange:NSMakeRange(0, _innerAttributeString.length) withString:text ?: @""];
    
    if (needAddAttributes) {
        _innerAttributeString.sc_font = _font;
        _innerAttributeString.sc_color = _color;
    }
    
    _text = text;
    
    [self sc_setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
    
    if (!color) {
        _color = [self sc_defaultColor];
    }
    
    if (_color == color || [_color isEqual:color]) {
        return;
    }
    
    _color = color;
    
    _innerAttributeString.sc_color = color;
    
    [self sc_setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    if (!font) {
        font = [self sc_defaultFont];
    }
    
    if (_font == font || [_font isEqual:font]) {
        return;
    }
    
    _font = font;
    
    _innerAttributeString.sc_font = font;
    
    [self sc_setNeedsDisplay];
}

@end
