//
//  ChatKeyboard.m
//  Chat
//
//  Created by 李立 on 2017/10/25.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatKeyboard.h"
#import <Masonry.h>

const CGFloat kChatKeyboardAnimationDuration = 0.25;

@interface ChatKeyboard ()

@end

@implementation ChatKeyboard

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self drawLine];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self drawLine];
    }
    
    return self;
}

- (instancetype)initWithTextView:(UITextView *)textView
{
    if (self = [super init])
    {
        self.textView = textView;
        [self drawLine];
    }
    
    return self;
}

- (instancetype)initWithTextField:(UITextField *)textField
{
    if (self = [super init])
    {
        self.textField = textField;
        [self drawLine];
    }
    
    return self;
}

- (void)drawLine
{
    // line
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = rgbColor(220, 220, 221, 1);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_offset(0);
        make.height.mas_offset(0.3);
    }];
}


@end




