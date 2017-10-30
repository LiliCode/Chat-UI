//
//  MessageCommon.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#ifndef _MESSAGE_COMMON_H_
#define _MESSAGE_COMMON_H_

/**
 消息类型
 
 - MessageTypeText: 文本类型的消息
 - MessageTypeImage: 图片类型的消息
 */
typedef NS_ENUM(NSUInteger, MessageType)
{
    MessageTypeText,
    MessageTypeImage,
};

/**
 消息方向-接受方还是发送方
 
 - MessageDirection_send: 消息发送方(我发出的消息)
 - MessageDirection_received: 消息接受方（我接收到的消息）
 */
typedef NS_ENUM(NSUInteger, MessageDirection)
{
    MessageDirection_send,
    MessageDirection_received
};


#define kInputControl_PluginButtonNormal @"icon_add_def"
#define kInputControl_PluginButtonHighlighted @"icon_add_pre"

#define kInputControl_EmojiButtonNormal @"icon_smile_def"
#define kInputControl_EmojiButtonHighlighted @"icon_smile_pre"

#define kInputControl_PenButtonNormal @"icon_inport_def"
#define kInputControl_PenButtonHighlighted @"icon_inport_def pre"

#define kMessageCell_BubbleImageSend @"chat_to_bg_normal"
#define kMessageCell_BubbleImageReceived @"chat_from_bg_normal"



#endif /* _MESSAGE_COMMON_H_ */







