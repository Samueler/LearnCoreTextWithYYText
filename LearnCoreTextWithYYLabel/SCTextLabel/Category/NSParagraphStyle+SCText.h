//
//  NSParagraphStyle+SCText.h
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSParagraphStyle (SCText)

+ (nullable NSParagraphStyle *)sc_styleWithCTStyle:(CTParagraphStyleRef)CTStyle;

@end
