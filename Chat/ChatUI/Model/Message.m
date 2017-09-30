//
//  Message.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithTargetId:(NSString *)targetId direction:(MessageDirection)direction content:(MessageContentItem *)content
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
