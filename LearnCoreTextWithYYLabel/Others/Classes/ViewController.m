//
//  ViewController.m
//  LearnCoreTextWithYYLabel
//
//  Created by Samueler on 2018/11/9.
//  Copyright © 2018年 Samueler.Chen. All rights reserved.
//

#import "ViewController.h"
#import "SCTextLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGFloat coreTextLabelW = self.view.frame.size.width - 20;
    CGFloat coreTextLabelW = 100;
    
    SCTextLabel *coreTextLabel = [[SCTextLabel alloc] initWithFrame:CGRectMake(10, 100, coreTextLabelW, 130)];
    coreTextLabel.text = @"LearnCoreTextWithYYLabelxxxxx";
    coreTextLabel.color = [UIColor orangeColor];
    coreTextLabel.font = [UIFont systemFontOfSize:20.f];
    coreTextLabel.textAlignment = NSTextAlignmentCenter;
    coreTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:coreTextLabel];
}


@end
