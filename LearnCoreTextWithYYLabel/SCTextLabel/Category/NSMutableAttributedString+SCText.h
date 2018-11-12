//
//  NSMutableAttributedString+SCText.h
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (SCText)

@property(nonatomic, strong) UIFont *sc_font;
- (void)sc_setFont:(UIFont *)font range:(NSRange)range;

@property(nonatomic, strong) UIColor *sc_color;
- (void)sc_setColor:(UIColor *)color range:(NSRange)range;

@end
