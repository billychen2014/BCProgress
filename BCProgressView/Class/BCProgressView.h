//
//  BCProgressView.h
//  BCProgressView
//
//  Created by Billy on 2017/1/23.
//  Copyright © 2017年 zzjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BCProgressViewType) {
    
    BCProgressViewTypeStraightLine = 5, //直线
    BCProgressViewTypeGradientLine,// 直线渐变
    BCProgressViewTypeCircle, //圆形
};

NS_ASSUME_NONNULL_BEGIN

@interface BCProgressView : UIView

/**
 *  进度条类型
 *  默认类型为 `BCProgressViewTypeStraightLine`
 */
@property (nonatomic, assign) BCProgressViewType progressType;

/**
 *  当前进度
 *  默认为0.0
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  进度条背景颜色(不同用于本view的背景色)
 *  默认为[UIColor lightGrayColor]
 */
@property (nonatomic, strong) UIColor *colorBackground;

/**
 *  进度条颜色
 *  默认为[UIColor orangeColor]
 */
@property (nonatomic, strong) UIColor *colorProgress;

/**
 *  有无动画效果
 *  默认为YES
 */
@property (nonatomic, assign) BOOL animated;

/**
 *  线条样式
 *  默认为kCALineCapRound
 */
@property(nonatomic, copy) NSString *lineCap;

/**
 *  渐变颜色，仅BCProgressViewTypeGradientLine有用
 *  默认为@[orangeColor, blueColor]
 */
@property (nonatomic, strong) NSArray<UIColor *> *arrayGradients;

/**
 *  线条宽度，仅type为BCProgressViewTypeCircle有用
 *  默认为2.0
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
