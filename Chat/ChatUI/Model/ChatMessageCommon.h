//
//  MessageCommon.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#ifndef _CHAT_MESSAGE_COMMON_H_
#define _CHAT_MESSAGE_COMMON_H_


#define DEBUG (0)   // 开启调试：1


/**
 消息类型
 
 - MessageTypeText: 文本类型的消息
 - MessageTypeImage: 图片类型的消息
 */
typedef NS_ENUM(NSUInteger, ChatMessageType)
{
    ChatMessageTypeText,
    ChatMessageTypeImage,
};

/**
 消息方向-接受方还是发送方
 
 - MessageDirection_send: 消息发送方(我发出的消息)
 - MessageDirection_received: 消息接受方（我接收到的消息）
 */
typedef NS_ENUM(NSUInteger, ChatMessageDirection)
{
    ChatMessageDirection_send,
    ChatMessageDirection_received
};


#define kInputControl_PluginButtonNormal @"chat_setmode_add_btn_normal"
#define kInputControl_PluginButtonHighlighted @"chat_setmode_add_btn_high"

#define kInputControl_EmojiButtonNormal @"chatting_biaoqing_btn_normal"
#define kInputControl_EmojiButtonHighlighted @"chatting_biaoqing_btn_high"

#define kInputControl_PenButtonNormal @"chat_setmode_key_btn_normal"
#define kInputControl_PenButtonHighlighted @"chat_setmode_key_btn_high"

#define kInputControl_VoiceButtonNormal @"chat_setmode_voice_btn_normal"
#define kInputControl_VoiceButtonHighlighted @"chat_setmode_voice_btn_high"

#define kMessageCell_BubbleImageSend @"chat_to_bg_normal"
#define kMessageCell_BubbleImageReceived @"chat_from_bg_normal"

#define kChatFcuntionView_PluginButtonImage @"actionbar_picture_icon"
#define kChatFcuntionView_PluginButtonCamera @"actionbar_camera_icon"



#endif /* _CHAT_MESSAGE_COMMON_H_ */







