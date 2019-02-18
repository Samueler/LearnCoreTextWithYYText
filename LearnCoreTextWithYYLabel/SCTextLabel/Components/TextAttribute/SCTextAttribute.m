//
//  SCTextAttribute.m
//  LearnCoreTextWithYYLabel
//
//  Created by samueler on 2019/2/13.
//  Copyright © 2019 Samueler.Chen. All rights reserved.
//

#import "SCTextAttribute.h"

NSString *const SCTextAttachmentAttributeName = @"SCTextAttachment";

@implementation SCTextAttachment

+ (instancetype)attachemetWithContent:(id)content {
    SCTextAttachment *attachment = [[SCTextAttachment alloc] init];
    attachment.content = content;
    return attachment;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:[NSValue valueWithUIEdgeInsets:self.contentInsets] forKey:@"contentInsets"];
    [aCoder encodeObject:self.userInfo forKey:@"userInfo"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _content = [aDecoder decodeObjectForKey:@"content"];
        _contentInsets = [(NSValue *)[aDecoder decodeObjectForKey:@"contentInsets"] UIEdgeInsetsValue];
        _userInfo = [aDecoder decodeObjectForKey:@"userInfo"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    typeof(self) attachment = [[self.class alloc] init];
    if ([self.content respondsToSelector:@selector(copy)]) {
        attachment.content = [self.content copy];
    } else {
        attachment.content = self.content;
    }
    
    attachment.contentInsets = self.contentInsets;
    attachment.userInfo = self.userInfo.copy;
    return attachment;
}

@end
