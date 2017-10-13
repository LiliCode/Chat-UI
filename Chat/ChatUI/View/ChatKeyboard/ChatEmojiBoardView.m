//
//  ChatEmojiBoardView.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatEmojiBoardView.h"

const CGFloat kChatEmojiKeyboardHeight = 250.0f;


@interface ChatEmojiBoardView ()

@end

@implementation ChatEmojiBoardView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepareUI];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self prepareUI];
    }
    
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor greenColor];
}



@end
