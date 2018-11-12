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

    CTFrameDraw(frame, context);

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
