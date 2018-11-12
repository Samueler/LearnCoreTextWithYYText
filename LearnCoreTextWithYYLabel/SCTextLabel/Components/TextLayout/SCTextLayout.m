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

@implementation SCTextLayout

+ (instancetype)sc_textLayoutWithContext:(CGContextRef)context attributeText:(NSAttributedString *)attributeString {
    SCTextLayout *layout = [[SCTextLayout alloc] init];
    layout.attributeString = attributeString;
    return layout;
}

#pragma mark - Public Functions

- (void)sc_textLayoutDrawWithContext:(CGContextRef)context containerRect:(CGRect)conainerRect {
    SCTextLayoutDrawText(self, context, conainerRect);
}

@end
