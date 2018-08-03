//
//  NSString+ChatUI.h
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIFont.h>

@interface NSString (ChatUI)

/**
 计算字符串文本的尺寸
 
 @param font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 @param maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 @return 该字符串所占的大小(width, height)
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
