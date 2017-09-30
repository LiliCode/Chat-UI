//
//  Message.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "MessageContentItem.h"
#import "MessageCommon.h"

/**
 消息实体类
 */
@interface Message : NSObject
/** 发送方用户信息 */
@property (strong , nonatomic) UserInfo *senderUserInfo;
/** 消息内容 */
@property (strong , nonatomic) MessageContentItem *messageContent;
/** 目标id - 要发送给谁 */
@property (copy , nonatomic) NSString *targetId;
/** 发送者id */
@property (copy , nonatomic) NSString *senderUserId;
/** 发送时间 - UNIX时间（s） */
@property (assign , nonatomic) NSUInteger sentTime;
/** 消息方向 */
@property (assign , nonatomic) MessageDirection direction;

/**
 初始化消息对象

 @param targetId 对方id
 @param direction 消息方向，如果是自己发送出去的就是:MessageDirection_send
 @param content 消息内容
 @return 返回已经初始化的消息对象
 */
- (instancetype)initWithTargetId:(NSString *)targetId direction:(MessageDirection)direction content:(MessageContentItem *)content;

@end


