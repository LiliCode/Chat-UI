//
//  ChatKeyboard.m
//  Chat
//
//  Created by 李立 on 2017/10/25.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatKeyboard.h"

const CGFloat kChatKeyboardAnimationDuration = 0.25;

@interface ChatKeyboard ()

@end

@implementation ChatKeyboard

- (instancetype)initWithTextView:(UITextView *)textView
{
    if (self = [super init])
    {
        self.textView = textView;
    }
    
    return self;
}

- (instancetype)initWithTextField:(UITextField *)textField
{
    if (self = [super init])
    {
        self.textField = textField;
    }
    
    return self;
}


@end
