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
#import "SCTextContainer.h"
#import "SCTextLine.h"

@interface SCTextLayout : NSObject

@property(nonatomic, copy) NSAttributedString *attributeString;
@property (nonatomic, strong, readonly) SCTextContainer *textContainer;
@property (nonatomic, assign, readonly) NSRange range;
@property (nonatomic, assign, readonly) CTFramesetterRef ctFrameSetter;
@property (nonatomic, assign, readonly) CTFrameRef ctFrame;
@property (nonatomic, assign, readonly) NSArray<SCTextLine *> *lines;
@property (nonatomic, strong, readonly) SCTextLine *truncatedLine;
@property (nonatomic, strong, readonly) NSArray<SCTextAttachment *> *attachments;
@property (nonatomic, strong, readonly) NSArray<NSValue *> *attachmentRanges;
@property (nonatomic, strong, readonly) NSArray<NSValue *> *attachmentRects;


+ (instancetype)sc_textLayoutWithContext:(CGContextRef)context attributeText:(NSAttributedString *)attributeString;

+ (instancetype)sc_textLayoutWithContainer:(SCTextContainer *)container attributeText:(NSAttributedString *)attributeString;

+ (instancetype)sc_textLayoutWithContainer:(SCTextContainer *)container attributeText:(NSAttributedString *)attributeString range:(NSRange)range;

- (void)sc_textLayoutDrawWithContext:(CGContextRef)context containerRect:(CGRect)containerRect;

@end
