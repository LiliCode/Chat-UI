//
//  ChatImageMessageContent.m
//  Chat
//
//  Created by 李立 on 2017/11/10.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatImageMessageContent.h"
#import "ChatUI.h"

/** 消息类型名称 */
NSString *const CHATUI_IMAGE_MESSAGE_CONTENT = @"ChatUI:imageMsg";

@implementation ChatImageMessageContent

- (NSString *)objectName
{
    return CHATUI_IMAGE_MESSAGE_CONTENT;
}

- (CGSize)contentSize
{
    return [ChatUI sharedUI].globalMessageImageSize;
}

@end
