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
    
    SCTextLabel *coreTextLabel = [[SCTextLabel alloc] initWithFrame:CGRectMake(100, 100, 200, 130)];
    coreTextLabel.text = @"LearnCoreTextWithYYLabel......";
    coreTextLabel.color = [UIColor orangeColor];
    coreTextLabel.font = [UIFont systemFontOfSize:20.f];
    [self.view addSubview:coreTextLabel];
    
}


@end
