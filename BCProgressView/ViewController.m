//
//  ViewController.m
//  BCProgressView
//
//  Created by Billy on 2017/1/23.
//  Copyright © 2017年 zzjr. All rights reserved.
//

#import "ViewController.h"
#import "BCProgressView.h"
#import "UIColor+HexColor.h"
#import "BCDashPatternView.h"

@interface ViewController ()

{
    UIView *view1;
    CALayer *layer;
}

@property (nonatomic,strong) BCProgressView *test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
 
    [self offical];
    
//    [self custom];
    
    BCDashPatternView *view = [[BCDashPatternView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 1)];

    [self.view addSubview:view];
}

- (void)offical {
    
    BCProgressView *test = [[BCProgressView alloc] initWithFrame:CGRectMake(50, 60, 250, 20)];
    self.test = test;
    [self.view addSubview:test];
    test.progress = 0.8;

    
    BCProgressView *test2 = [[BCProgressView alloc] initWithFrame:CGRectMake(50, 110, 250, 250)];
    [self.view addSubview:test2];
    test2.progress = 0.45;
    test2.progressType = BCProgressViewTypeCircle;
    test2.lineWidth = 20;
//
//    BCProgressView *test3 = [[BCProgressView alloc] initWithFrame:CGRectMake(50, 400, 250, 20)];
//    [self.view addSubview:test3];
//    test3.progress = 0.65;
//    test3.progressType = BCProgressViewTypeGradientLine;
}

- (void)custom {
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 250, 10)];
    
    [view1 setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:view1];
    
    
    layer = [CALayer layer];
    
    [view1.layer addSublayer:layer];
    
    [layer setFrame:CGRectMake(0, 0, 0, 10)];
    [layer setBackgroundColor:[UIColor orangeColor].CGColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    self.test.animated = YES;
    self.test.lineWidth = 20;
    
    self.test.colorBackground = [UIColor blueColor];
    
    self.test.colorProgress = [UIColor cyanColor];
}

@end
