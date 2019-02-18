//
//  SCTextContainer.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "SCTextContainer.h"

const CGSize SCTextContainerMaxSize = (CGSize) {0x100000, 0x100000};

static inline CGSize SCTextClipCGSize(CGSize size) {
    if (size.width > SCTextContainerMaxSize.width) {
        size.width = SCTextContainerMaxSize.width;
    }
    
    if (size.height > SCTextContainerMaxSize.height) {
        size.height = SCTextContainerMaxSize.height;
    }
    return size;
}

@implementation SCTextContainer

+ (instancetype)containerWithSize:(CGSize)size {
    return [self containerWithSize:size insets:UIEdgeInsetsZero];
}

+ (instancetype)containerWithSize:(CGSize)size insets:(UIEdgeInsets)insets {
    SCTextContainer *container = [[SCTextContainer alloc] init];
    container.size = SCTextClipCGSize(size);
    container.insets = insets;
    return container;
}

+ (instancetype)containerWithPath:(UIBezierPath *)path {
    SCTextContainer *container = [[SCTextContainer alloc] init];
    container.path = path;
    return container;
}

@end
