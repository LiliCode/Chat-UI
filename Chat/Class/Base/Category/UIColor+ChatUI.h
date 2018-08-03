//
//  UIColor+ChatUI.h
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>


extern UIColor *rgbColor(CGFloat r, CGFloat g, CGFloat b, CGFloat alpha);

@interface UIColor (ChatUI)

/**
 三基色颜色

 @param r 红色通道
 @param g 绿色通道
 @param b 蓝色通道
 @param alpha 透明度通道
 @return 返回颜色实例
 */
+ (instancetype)rgbColorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

@end
