//
//  ChatPluginBoardView.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatPluginBoardView.h"


NSString * const kChatPluginKeyboardWillShowNotification = @"kChatPluginKeyboardWillShowNotification";
NSString * const kChatPluginKeyboardWillHideNotification = @"kChatPluginKeyboardWillHideNotification";
NSString * const kChatPluginKeyboardDidShowNotification = @"kChatPluginKeyboardDidShowNotification";
NSString * const kChatPluginKeyboardDidHideNotification = @"kChatPluginKeyboardDidHideNotification";

const CGFloat kChatPluginKeyboardHeight = 200.0f;


@interface ChatPluginBoardView ()

@end

@implementation ChatPluginBoardView

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
    self.backgroundColor = [UIColor yellowColor];
}








@end







