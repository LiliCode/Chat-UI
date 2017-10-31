//
//  UIColor+ChatUI.m
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "UIColor+ChatUI.h"

UIColor *rgbColor(CGFloat r, CGFloat g, CGFloat b, CGFloat alpha)
{
    return [UIColor rgbColorWithR:r G:g B:b alpha:alpha];
}

@implementation UIColor (ChatUI)

+ (instancetype)rgbColorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha];
}

@end
