//
//  ChatImageMessageContent.h
//  Chat
//
//  Created by 李立 on 2017/11/10.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageContent.h"

/** 消息类型名称 */
FOUNDATION_EXTERN NSString *const CHATUI_IMAGE_MESSAGE_CONTENT;

@interface ChatImageMessageContent : ChatMessageContent
/** 图片：可能是UIImage对象，可能是图片链接字符串NSString对象 */
@property (strong , nonatomic) id image;

@end
