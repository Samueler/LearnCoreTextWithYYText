//
//  SCTextLine.h
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "SCTextAttribute.h"

@interface SCTextLine : NSObject

+ (instancetype)lineWithCTLine:(CTLineRef)CTLine baseLinePosition:(CGPoint)position vertical:(BOOL)isVertical;

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger row;

@property (nonatomic, assign, readonly) CTLineRef CTLine;
@property (nonatomic, assign, readonly) NSRange range;
@property (nonatomic, assign, readonly) BOOL vertical;
@property (nonatomic, assign, readonly) CGRect bounds;
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readonly) CGFloat right;

@property (nonatomic, assign) CGPoint baseLinePosition;
@property (nonatomic, assign, readonly) CGFloat ascent;
@property (nonatomic, assign, readonly) CGFloat descent;
@property (nonatomic, assign, readonly) CGFloat leading;
@property (nonatomic, assign, readonly) CGFloat lineWidth;
@property (nonatomic, assign, readonly) CGFloat trailingWhitespaceWidth;

@property (nonatomic, strong) NSArray<SCTextAttachment *> *attachments;
@property (nonatomic, strong) NSArray<NSValue *> *attachmentRanges;
@property (nonatomic, strong) NSArray<NSValue *> *attachmentRects;

@end
