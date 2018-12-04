//
//  Target_Chat.m
//  Chat
//
//  Created by 唯赢 on 2018/12/4.
//  Copyright © 2018 李立. All rights reserved.
//

#import "Target_Chat.h"
#import "ChatConversationViewController.h"

@implementation Target_Chat

+ (id)conversation:(NSDictionary *)parameter {
    ChatConversationViewController *chat = [[ChatConversationViewController alloc] init];
    chat.targetId = [NSString stringWithFormat:@"%@", parameter[@"targetId"]];
    return chat;
}

+ (id)conversationList {
    return nil;
}

@end
