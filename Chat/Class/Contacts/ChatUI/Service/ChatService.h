//
//  ChatService.h
//  Chat
//
//  Created by 唯赢 on 2018/8/3.
//  Copyright © 2018年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatMessage.h"

@interface ChatService : NSObject<NSCopying, NSMutableCopying>

/**
 共享聊天服务对象

 @return ChatService *
 */
+ (instancetype)sharedService;

/**
 发送消息

 @param message 消息实体对象
 @param callback 发送之后的回调，error不为空，则发送失败
 */
- (void)sendMessage:(ChatMessage *)message callback:(void (^)(NSError *error))callback;

@end
