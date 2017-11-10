//
//  Message.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage

- (instancetype)initWithTargetId:(NSString *)targetId direction:(ChatMessageDirection)direction content:(ChatMessageContent *)content
{
    if (self = [super init])
    {
        self.targetId = targetId;
        self.direction = direction;
        self.messageContent = content;
        self.sentTime = (NSUInteger)[NSDate date].timeIntervalSince1970;
    }
    
    return self;
}

@end
