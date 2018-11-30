//
//  Message.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatUserInfo.h"
#import "ChatMessageContent.h"
#import "ChatMessageCommon.h"

/**
 消息实体类
 */
@interface ChatMessage : NSObject
/** 发送方用户信息 */
@property (strong , nonatomic) ChatUserInfo *senderUserInfo;
/** 消息内容 */
@property (strong , nonatomic) ChatMessageContent *messageContent;
/** 目标id - 要发送给谁 */
@property (copy , nonatomic) NSString *targetId;
/** 发送者id */
@property (copy , nonatomic) NSString *senderUserId;
/** 发送时间 - UNIX时间（s） */
@property (assign , nonatomic) NSUInteger sentTime;
/** 消息方向 */
@property (assign , nonatomic) ChatMessageDirection direction;

/**
 初始化消息对象

 @param targetId 对方id
 @param direction 消息方向，如果是自己发送出去的就是:MessageDirection_send
 @param content 消息内容
 @return 返回已经初始化的消息对象
 */
- (instancetype)initWithTargetId:(NSString *)targetId direction:(ChatMessageDirection)direction content:(ChatMessageContent *)content;

@end


