//
//  BCDashPatternView.m
//  BCProgressView
//
//  Created by Billy on 2017/1/25.
//  Copyright © 2017年 zzjr. All rights reserved.
//

#import "BCDashPatternView.h"

@implementation BCDashPatternView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.lineDashPattern = @[@20,@5];// 调整线条的宽度， 20是线条宽度，5是间隔宽度
        self.colorDashpatter = [UIColor lightGrayColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [self dashPatterCreation];
}

#pragma mark - Implementation

- (void)dashPatterCreation {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:self.colorDashpatter.CGColor];
    [shapeLayer setPath:path.CGPath];
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineDashPattern:self.lineDashPattern];
}

#pragma mark - Return custom layer of this view

+ (Class)layerClass {
    
    return [CAShapeLayer class];
}

@end
