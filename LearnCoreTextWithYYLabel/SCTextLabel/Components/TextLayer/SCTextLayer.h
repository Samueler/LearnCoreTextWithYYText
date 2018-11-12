//
//  SCTextLayer.h
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef void(^SCTextLayerDisplaying)(CGContextRef context, CGSize size);

@protocol SCTextLayerDelegate <NSObject>

@required

- (void)sc_textLayerDisplay;

@end

@interface SCTextLayer : CALayer

@property(nonatomic, copy) SCTextLayerDisplaying textLayerDisplaying;

@end
