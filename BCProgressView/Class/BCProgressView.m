//
//  BCProgressView.m
//  BCProgressView
//
//  Created by Billy on 2017/1/23.
//  Copyright © 2017年 zzjr. All rights reserved.
//

#import "BCProgressView.h"
#import <objc/runtime.h>

@interface BCProgressView ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *layerProgress;//进度图层
@property (nonatomic, strong) id layerBg;//背景图层
@end

@implementation BCProgressView

#pragma mark - Initial (初始化方法)

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self defaultConfiguration];
        [self regsiterKVO];
    }
    
    return self;
}

#pragma mark - Layout

/**
 *  考虑到KVO底层实现，所有的功能在这儿实现
 *
 */
- (void)layoutSubviews {
    
    NSLog(@"layoutSubviews");
    if (self.progressType == BCProgressViewTypeStraightLine) {
        
        [self createStraightLineProgress];
    } else if(self.progressType  == BCProgressViewTypeGradientLine) {
        
        [self createGradientLineProgress];
    } else if(self.progressType  == BCProgressViewTypeCircle) {
        
        [self createCycleProgress];
    }
}

#pragma mark - Detail implementation (具体各个样式的实现)

/**
 *  创建直线进度条
 *  step 1: 创建背景的直线
 *  step 2 (有动画 or 无动画)
 *  step 2.1: 有动画，创建进度条的直线，利用cashaperlayer path属性做动画
 *  step 2.2: 无动画
 */

- (void)createStraightLineProgress {
  
    //层次关系 ,进度layer 直接加在self.layer上
    [self.layer setBackgroundColor:self.colorBackground.CGColor];
    [self.layer addSublayer:self.layerProgress];
    [self.layer setMasksToBounds:YES];
    
    //路径指定
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 这儿有个问题，如果是从(0, 0)开始, layer画图会往上和下开始画，why?
    [path moveToPoint:CGPointMake(0,CGRectGetHeight(self.frame)/2.0 )];
    
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2.0)];
    [self.layerProgress setPath:path.CGPath];
    
    //颜色指定
    [self.layerProgress setStrokeColor:self.colorProgress.CGColor];
    [self.layerProgress setFillColor:[UIColor clearColor].CGColor];
    
    [self.layerProgress setLineWidth:CGRectGetHeight(self.frame)];
    [self.layerProgress setLineCap:self.lineCap];
    
    if (self.animated) {
        
        //动画效果
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        [pathAnima setDuration:0.5];
        [pathAnima setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [pathAnima setFromValue:[NSNumber numberWithFloat:0.0f]];
        [pathAnima setToValue:[NSNumber numberWithFloat:self.progress]];
        
        [pathAnima setFillMode:kCAFillModeForwards];
        [pathAnima setRemovedOnCompletion:NO];
        
        [self.layerProgress addAnimation:pathAnima forKey:nil];
        
    }else{

        [self.layerProgress setStrokeEnd:self.progress];
    }
}

/**
 *  直线渐变形进度条
 */
- (void)createGradientLineProgress {
    
    //层次关系 ,进度layer 直接加在self.layer上
    
    [self.layer setBackgroundColor:self.colorBackground.CGColor];
    self.layerBg = [CAGradientLayer layer];
    [self.layerBg setFrame:self.bounds];
    [self.layer addSublayer:self.layerBg];
    
    //指定渐变点
    [self.layerBg setStartPoint:CGPointMake(0, 0.5)];
    [self.layerBg setEndPoint:CGPointMake(1.0, 0.5)];
    
    //指定渐变颜色
    [self.layerBg setColors:@[(id)self.arrayGradients[0].CGColor,(id)self.arrayGradients[1].CGColor]];

    //指定遮罩图层
    CAShapeLayer *layerMask = [CAShapeLayer layer];
    
    [layerMask setFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
    
    [layerMask setBackgroundColor:self.colorProgress.CGColor];
    [self.layerBg setMask:layerMask];
    [layerMask setLineCap:self.lineCap]; //如果圆角不起作用，可以将此layer的coreordius属性用起来
    
    if (self.animated) {
        
        CGRect maskRect = [layerMask frame];
        maskRect.size.width = CGRectGetWidth(self.frame) * self.progress*2 ; //为什么这儿要乘2
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        
        [animation setDelegate:self];
        [animation setFromValue:[NSValue valueWithCGRect:layerMask.bounds]];
        [animation setToValue:[NSValue valueWithCGRect:maskRect]];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [animation setRemovedOnCompletion:NO];
        [animation setDuration:0.5];
        [animation setFillMode:kCAFillModeForwards];
        
        [layerMask addAnimation:animation forKey:nil];
        
        
    }else {
        
      [layerMask setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame)*self.progress, self.bounds.size.height)];
    }
    
}

/**
 *  圆线形进度条
 */
- (void)createCycleProgress {
    
    //取得合适的半径
    CGFloat raidous = MIN(self.bounds.size.width/2 - self.lineWidth, self.bounds.size.height/2 - self.lineWidth);
    
    UIBezierPath *path = [UIBezierPath  bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:raidous startAngle:-M_PI/2  endAngle:M_PI*1.5 clockwise:YES];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    //背景圆
    [self.layerBg setFrame:self.bounds];
    [self.layerBg setPath:path.CGPath];
    [self.layerBg setFillColor:[UIColor clearColor].CGColor];
    [self.layerBg setLineWidth:self.lineWidth];
    [self.layerBg setStrokeColor:self.colorBackground.CGColor];
    [self.layerBg setStrokeStart:0.0];
    [self.layerBg setStrokeEnd:1.0];
    
    [self.layer addSublayer:self.layerBg];
    
    //进度圆
    [self.layerProgress setFrame:self.bounds];
    [self.layerProgress setPath:path.CGPath];
    [self.layerProgress setFillColor:[UIColor clearColor].CGColor];
    [self.layerProgress setLineWidth:self.lineWidth];
    [self.layerProgress setStrokeColor:self.colorProgress.CGColor];
    [self.layerBg addSublayer:self.layerProgress];
    
    if (self.animated) {
        
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        [pathAnima setDuration:0.5];
        [pathAnima setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [pathAnima setFromValue:[NSNumber numberWithFloat:0.0f]];
        [pathAnima setToValue:[NSNumber numberWithFloat:self.progress]];
        
        [pathAnima setFillMode:kCAFillModeForwards];
        [pathAnima setRemovedOnCompletion:NO];
        
        [self.layerProgress addAnimation:pathAnima forKey:nil];
        
    }else {
        
        [self.layerProgress setStrokeEnd:self.progress];
    }
    
}

#pragma mark - Animation delegate(动画monitor)

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    
}

#pragma mark - KVO methods list (KVO相关方法)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //适合于view已经创建成功，但是要修改某个属性值的时候
    
    NSLog(@"修改");
    [self setNeedsLayout];
}

- (void)regsiterKVO {
    
    for (NSString *key in [self allProperties]) {
        
        [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)unregisterFromKVO {
    
    for (NSString *key in [self allProperties]) {
        
        [self removeObserver:self forKeyPath:key];
    }
}

#pragma mark - Supported methods list (支持该类的一些方法)

/**
 * 该view的一些默认配置，不设置任何属性时的样子
 */
- (void)defaultConfiguration {
    
    [self setProgressType:BCProgressViewTypeStraightLine];
    [self setColorBackground:[UIColor lightGrayColor]];
    [self setColorProgress:[UIColor orangeColor]];
    [self setArrayGradients:@[[UIColor orangeColor], [UIColor blueColor]]];
    [self setAnimated:YES];
    [self setLineCap:kCALineCapRound];
    [self setLineWidth:2.0];
    
    self.layerProgress= [CAShapeLayer layer]; //这儿初始化layer的原因是防止死loop调用,因为addsubleayer也会触layoutsubview
    self.layerBg = [CAShapeLayer layer];
}

/**
 * 该view的所有属性，没有实例变量，所以用class_copyPropertyList but no class_copyIvarList
 */
- (NSArray *)allProperties {
    
    NSMutableArray *arrayTmp = [NSMutableArray array];
    
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        
        NSString *name = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        
        [arrayTmp addObject:name];
    }
    
    return arrayTmp;
}

- (void)dealloc {
    
    [self unregisterFromKVO];
}

@end
