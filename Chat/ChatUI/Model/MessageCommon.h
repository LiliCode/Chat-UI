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
 
 - MessageDirection_send: 消息发送方
 - MessageDirection_received: 消息接受方
 */
typedef NS_ENUM(NSUInteger, MessageDirection)
{
    MessageDirection_send,
    MessageDirection_received
};





#endif /* _MESSAGE_COMMON_H_ */
