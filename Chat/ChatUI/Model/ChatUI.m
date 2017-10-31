//
//  ChatUI.m
//  Chat
//
//  Created by 李立 on 2017/10/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatUI.h"

@implementation ChatUI

static ChatUI *chatui = nil;

+ (instancetype)sharedUI
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatui = [[self alloc] init];
        // 初始化
        chatui.globalMessageAvatarStyle = USER_AVATAR_RECTANGLE;
        chatui.globalMessagePortraitSize = CGSizeMake(40, 40);
        chatui.globalConversationPortraitSize = CGSizeMake(46, 46);
        chatui.portraitImageViewCornerRadius = 4.0f;
        chatui.globalMessageTextFont = [UIFont systemFontOfSize:16.0f];
        chatui.globalMessageTextColor = [UIColor blackColor];
        chatui.globalMessageContentViewMaxWidth = 250.0f;
    });
    
    return chatui;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t allocToken;
    dispatch_once(&allocToken, ^{
        chatui = [super allocWithZone:zone];
    });
    
    return chatui;
}

- (id)copyWithZone:(NSZone *)zone
{
    return chatui;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return chatui;
}

#pragma mark - public API







@end






