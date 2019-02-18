//
//  SCTextLayout.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "SCTextLayout.h"

static void SCTextLayoutDrawText(SCTextLayout *textLayout, CGContextRef context, CGRect
                                 containerRect) {
    
    // Flip the context coordinates
    CGContextTranslateCTM(context, 0, containerRect.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);

    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)textLayout.attributeString);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, (CGRect) {CGPointZero, containerRect.size});

    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, textLayout.attributeString.length), path, NULL);

    // Draw text with Frame
//    CTFrameDraw(frame, context);
    
    // Draw text with lines or runs
    
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint *lineOrigins = malloc(lineCount * sizeof(CGPoint));
    CTFrameGetLineOrigins(frame, CFRangeMake(0, CFArrayGetCount(lines)), lineOrigins);
    
    // Draw text with lines
//    for (NSUInteger idx = 0; idx < lineCount; idx++) {
//        CTLineRef line = CFArrayGetValueAtIndex(lines, idx);
//        CGPoint position = lineOrigins[idx];
//        CGContextSetTextPosition(context, position.x, position.y);
//        CTLineDraw(line, context);
//    }

    // Draw text with runs
    for (NSUInteger idx = 0; idx < lineCount; idx++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, idx);

        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (NSUInteger runIdx = 0; runIdx < CFArrayGetCount(runs); runIdx++) {

            CGPoint position = lineOrigins[idx];
            CGContextSetTextPosition(context, position.x, position.y);
            CTRunDraw(CFArrayGetValueAtIndex(runs, runIdx), context, CFRangeMake(0, 0));
        }
    }

    CFRelease(frameSetter);
    CFRelease(frame);
    CFRelease(path);
}

@interface SCTextLayout ()

@property (nonatomic, strong) SCTextContainer *textContainer;
@property (nonatomic, assign) NSRange range;

@end

@implementation SCTextLayout

+ (instancetype)sc_textLayoutWithContext:(CGContextRef)context attributeText:(NSAttributedString *)attributeString {
    SCTextLayout *layout = [[SCTextLayout alloc] init];
    layout.attributeString = attributeString;
    return layout;
}

+ (instancetype)sc_textLayoutWithContainer:(SCTextContainer *)container attributeText:(NSAttributedString *)attributeString {
    return [self sc_textLayoutWithContainer:container attributeText:attributeString range:NSMakeRange(0, attributeString.length)];
}

+ (instancetype)sc_textLayoutWithContainer:(SCTextContainer *)container attributeText:(NSAttributedString *)attributeString range:(NSRange)range {
    SCTextLayout *textLayout = nil;
    CGPathRef cgPath = nil;
    NSMutableDictionary *frameAttrs = nil;
    CTFramesetterRef ctFrameSetter = NULL;
    CTFrameRef ctFrame = NULL;
    CFArrayRef ctLines = NULL;
    CGPoint *lineOrigins = NULL;
    NSUInteger lineCount = 0;
    NSMutableArray *lines = nil;
    BOOL needTruncation = NO;
    NSAttributedString *truncationToken = nil;
    SCTextLine *truncatedLine = nil;
    NSUInteger maximumNumberOfRows = 0;
    
    attributeString = attributeString.mutableCopy;
    container = container.mutableCopy;
    if (!attributeString || !container) {
        return nil;
    }
    
    if (range.location + range.length > attributeString.length) {
        return nil;
    }
    
    maximumNumberOfRows = container.maximumNumberOfRows;
    
    textLayout = [[SCTextLayout alloc] init];
    textLayout.attributeString = attributeString;
    textLayout.textContainer = container;
    textLayout.range = range;
    
    if (!container.path) {
        if (container.size.width <= 0 || container.size.height <= 0) {
            goto fail;
        }
        
        CGRect rect = (CGRect) {CGPointZero, container.size};
        rect = UIEdgeInsetsInsetRect(rect, container.insets);
        rect = CGRectStandardize(rect);
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(1, -1));
        cgPath = CGPathCreateWithRect(rect, NULL);
    } else if (container)
    
    return textLayout;
    
fail:
    if (cgPath) {
        CFRelease(cgPath);
    }
    
    if (ctFrameSetter) {
        CFRelease(ctFrameSetter);
    }
    
    if (ctFrame) {
        CFRelease(ctFrame);
    }
    
    if (lineOrigins) {
        free(lineOrigins);
    }
    return nil;
}

#pragma mark - Public Functions

- (void)sc_textLayoutDrawWithContext:(CGContextRef)context containerRect:(CGRect)conainerRect {
    SCTextLayoutDrawText(self, context, conainerRect);
}

@end
