//
//  UIView+ChatFrame.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "UIView+ChatUI.h"

@implementation UIView (ChatUI)

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (CGPoint)origin
{
    return self.bounds.origin;
}

@end
