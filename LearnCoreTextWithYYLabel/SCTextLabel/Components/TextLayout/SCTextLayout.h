//
//  SCTextLayout.h
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface SCTextLayout : NSObject

@property(nonatomic, copy) NSAttributedString *attributeString;

+ (nullable instancetype)sc_textLayoutWithContext:(CGContextRef)context attributeText:(NSAttributedString *)attributeString;

- (void)sc_textLayoutDrawWithContext:(CGContextRef)context containerRect:(CGRect)containerRect;

@end
