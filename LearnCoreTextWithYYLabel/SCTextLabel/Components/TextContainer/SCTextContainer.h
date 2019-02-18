//
//  SCTextContainer.h
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTextContainer : NSObject

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) NSUInteger maximumNumberOfRows;

@property (nonatomic, copy) NSAttributedString *truncationToken;

+ (instancetype)containerWithSize:(CGSize)size;

+ (instancetype)containerWithSize:(CGSize)size insets:(UIEdgeInsets)insets;

+ (instancetype)containerWithPath:(nullable UIBezierPath *)path;

@end
