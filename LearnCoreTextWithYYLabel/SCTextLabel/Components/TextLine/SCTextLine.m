//
//  SCTextLine.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "SCTextLine.h"

#ifndef SCTEXT_SWAP // swap two value
#define SCTEXT_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif

@implementation SCTextLine {
    CGFloat _firstGlyphPos;
}

+ (instancetype)lineWithCTLine:(CTLineRef)CTLine baseLinePosition:(CGPoint)position vertical:(BOOL)isVertical {
    if (!CTLine) {
        return nil;
    }
    
    SCTextLine *line = [[SCTextLine alloc] init];
    line->_baseLinePosition = position;
    line->_vertical = isVertical;
    [line setCTLine:CTLine];
    return line;
}

- (void)setCTLine:(CTLineRef)CTLine {
    if (_CTLine == CTLine) {
        return;
    }
    
    if (CTLine) {
        CFRetain(CTLine);
    }
    
    if (_CTLine) {
        CFRelease(_CTLine);
    }
    
    _CTLine = CTLine;
    
    if (_CTLine) {
        _lineWidth = CTLineGetTypographicBounds(_CTLine, &_ascent, &_descent, &_leading);
        CFRange range = CTLineGetStringRange(_CTLine);
        _range = NSMakeRange(range.location, range.length);
        if (CTLineGetGlyphCount(_CTLine)) {
            CFArrayRef runs = CTLineGetGlyphRuns(_CTLine);
            CTRunRef run = CFArrayGetValueAtIndex(runs, 0);
            CGPoint pos;
            CTRunGetPositions(run, CFRangeMake(0, 1), &pos);
            _firstGlyphPos = pos.x;
        } else {
            _firstGlyphPos = 0;
        }
        
        _trailingWhitespaceWidth = CTLineGetTrailingWhitespaceWidth(_CTLine);
    } else {
        _lineWidth = _ascent = _descent = _leading = _firstGlyphPos = _trailingWhitespaceWidth = 0;
        _range = NSMakeRange(0, 0);
    }
    
    [self reloadBounds];
}

- (void)reloadBounds {
    if (_vertical) {
        _bounds = CGRectMake(_baseLinePosition.x - _descent, _baseLinePosition.y, _ascent + _descent, _lineWidth);
        _bounds.origin.y += _firstGlyphPos;
    } else {
        _bounds = CGRectMake(_baseLinePosition.x, _baseLinePosition.y, _lineWidth, _ascent + _descent);
        _bounds.origin.x += _firstGlyphPos;
    }
    
    _attachments = nil;
    _attachmentRanges = nil;
    _attachmentRects = nil;
    if (!_CTLine) {
        return;
    }
    
    CFArrayRef runs = CTLineGetGlyphRuns(_CTLine);
    NSUInteger runCount = CFArrayGetCount(runs);
    if (!runCount) {
        return;
    }
    
    NSMutableArray *attachments = [NSMutableArray array];
    NSMutableArray *attachmentRanges = [NSMutableArray array];
    NSMutableArray *attachmentRects = [NSMutableArray array];
    
    for (NSUInteger idx = 0; idx < runCount; idx++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, idx);
        CFIndex glyphCount = CTRunGetGlyphCount(run);
        if (!glyphCount) {
            continue;
        }
        
        NSDictionary *attrs = (id)CTRunGetAttributes(run);
        SCTextAttachment *attachment = attrs[SCTextAttachmentAttributeName];
        if (attachment) {
            CGPoint runPosition = CGPointZero;
            CTRunGetPositions(run, CFRangeMake(0, 0), &runPosition);
            
            CGFloat ascent, descent, leading, runWidth;
            CGRect runTypoBounds;
            runWidth = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
            
            if (_vertical) {
                SCTEXT_SWAP(runPosition.x, runPosition.y);
                runPosition.y = _baseLinePosition.y + runPosition.y;
                runTypoBounds = CGRectMake(_baseLinePosition.x + runPosition.x - descent, runPosition.y , ascent + descent, runWidth);
            } else {
                runPosition.x += _baseLinePosition.x;
                runPosition.y = _baseLinePosition.y - runPosition.y;
                runTypoBounds = CGRectMake(runPosition.x, runPosition.y - ascent, runWidth, ascent + descent);
            }
            
            CFRange cfRunRange = CTRunGetStringRange(run);
            NSRange runRange = NSMakeRange(cfRunRange.location, cfRunRange.length);
            [attachments addObject:attachment];
            [attachmentRanges addObject:[NSValue valueWithRange:runRange]];
            [attachmentRects addObject:[NSValue valueWithCGRect:runTypoBounds]];
        }
    }
    
    _attachments = attachments.count ? attachments : nil;
    _attachmentRanges = attachmentRanges.count ? attachmentRanges : nil;
    _attachmentRects = attachmentRects.count ? attachmentRects : nil;
}

#pragma mark - Dealloc

- (void)dealloc {
    if (_CTLine) {
        CFRelease(_CTLine);
    }
}

@end
