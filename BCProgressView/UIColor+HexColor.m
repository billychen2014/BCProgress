
#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (instancetype)colorWithHexString:(NSString *)hexColorStr {
    
    //转成大写，并去掉空格，空行
    NSString *strColor = [[hexColorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //格式不对时的处理
    if ([strColor length] < 6) {
        
        return [UIColor blackColor];
    }
    
    //取出传入的值必要的部分(16进制颜色格式一定是6位长)
    
    if ([strColor hasPrefix:@"0x"]) {
        
        strColor = [strColor substringFromIndex:2];
    }
    
    if ([strColor hasPrefix:@"#"]) {
        
        strColor = [strColor substringFromIndex:1];
    }
    
    if ([strColor length] != 6) {
        
        return [UIColor blackColor];
    }
    
    NSRange range;
    
    range.location = 0;
    range.length = 2;
    
    //取出R, G, B 色值
    NSString *rStr = [strColor substringWithRange:range];
    
    range.location = 2;
    NSString *gStr = [strColor substringWithRange:range];
    
    range.location = 4;
    NSString *bStr = [strColor substringWithRange:range];
    
    //换算出对应的值,按官方文档来说，如果是0x开头，应该用scanHexInt方法
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    UIColor *colorTmp = [UIColor colorWithRed:(r/255.0f) green:(r/255.0f) blue:(r/255.0f) alpha:1.0f];

    return colorTmp;
}

@end
