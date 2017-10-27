//
//  ChatTableView.m
//  Chat
//
//  Created by 李立 on 2017/10/27.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatTableView.h"

@implementation ChatTableView


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id view = [super hitTest:point withEvent:event];
    if ([self.chatDelegate respondsToSelector:@selector(clickTableView:)])
    {
        [self.chatDelegate clickTableView:view];
    }
    
    return view;
}


@end
