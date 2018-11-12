//
//  SCTextLayer.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "SCTextLayer.h"
#import <CoreText/CoreText.h>

@implementation SCTextLayer

- (void)display {
    super.contents = super.contents;

    [self sc_textLayerDisplay];
}

#pragma mark - Private Functions

- (void)sc_textLayerDisplay {

    __strong id<SCTextLayerDelegate>delegate = (id)self.delegate;

    if (delegate && [delegate respondsToSelector:@selector(sc_textLayerDisplay)]) {
        [delegate sc_textLayerDisplay];
    }

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, self.contentsScale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (self.opaque && context) {
        CGSize size = self.bounds.size;
        size.width *= self.contentsScale;
        size.height *= self.contentsScale;

        if (!self.backgroundColor || CGColorGetAlpha(self.backgroundColor) < 1) {
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddRect(context, self.bounds);
            CGContextFillPath(context);
        }

        if (self.backgroundColor) {
            CGContextSetFillColorWithColor(context, self.backgroundColor);
            CGContextAddRect(context, self.bounds);
            CGContextFillPath(context);
        }
    }

    if (self.textLayerDisplaying) {
        self.textLayerDisplaying(context, self.bounds.size);
    }

    UIImage *contentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.contents = (__bridge id)contentImage.CGImage;
}

@end
