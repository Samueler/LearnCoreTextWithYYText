//
//  SCTextAttribute.h
//  LearnCoreTextWithYYLabel
//
//  Created by samueler on 2019/2/13.
//  Copyright © 2019 Samueler.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const SCTextAttachmentAttributeName;

@interface SCTextAttachment : NSObject <NSCoding, NSCopying>

+ (instancetype)attachemetWithContent:(id)content;
@property (nonatomic, strong) id content;
@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, strong) NSDictionary *userInfo;

@end
