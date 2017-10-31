//
//  TextMessageContent.h
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "MessageContent.h"

/** 消息类型名称 */
FOUNDATION_EXTERN NSString *const CHATUI_TEXT_MESSAGE_CONTENT;

@interface TextMessageContent : MessageContent
/** 文本信息 */
@property (copy , nonatomic) NSString *text;


@end
