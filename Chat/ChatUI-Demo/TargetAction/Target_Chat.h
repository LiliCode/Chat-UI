//
//  Target_Chat.h
//  Chat
//
//  Created by 唯赢 on 2018/12/4.
//  Copyright © 2018 李立. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_Chat : NSObject


/**
 会话列表
 -- router: chat/conversation?targetId=x

 @param parameter 参数 {targetId: 会话目标id，对方的id}
 @return 会话页面控制器
 */
+ (id)conversation:(NSDictionary *)parameter;

/**
 会话列表，从缓存中获取
 -- router: chat/conversationList
 
 @return 会话列表控制器
 */
+ (id)conversationList;

@end

NS_ASSUME_NONNULL_END
