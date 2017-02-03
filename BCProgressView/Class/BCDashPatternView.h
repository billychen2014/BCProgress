//
//  BCDashPatternView.h
//  BCProgressView
//
//  Created by Billy on 2017/1/25.
//  Copyright © 2017年 zzjr. All rights reserved.
//

//虚线view ,e.g.:- - -  -  - - 

#import <UIKit/UIKit.h>

@interface BCDashPatternView : UIView

/**
 *  虚线view
 *  默认:@[@20,@5], 20:每段线的长度，5:每段线的间隔
 */
@property(nonatomic, strong) NSArray<NSNumber *> *lineDashPattern;

/** 线条颜色,默认lightGrayColor */
@property(nonatomic, strong) UIColor *colorDashpatter;

@end
