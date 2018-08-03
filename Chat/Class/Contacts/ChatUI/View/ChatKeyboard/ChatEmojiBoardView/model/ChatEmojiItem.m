//
//  EmojiItem.m
//  Chat
//
//  Created by 李立 on 2017/10/20.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatEmojiItem.h"

@implementation ChatEmojiItem

+ (instancetype)emojiWithEncode:(NSString *)encode type:(ChatEmojiItemType)type
{
    return [[self alloc] initWithEncode:encode type:type];
}

- (instancetype)initWithEncode:(NSString *)encode type:(ChatEmojiItemType)type
{
    if (self = [super init])
    {
        self.emojiEncode = encode;
        self.type = type;
    }
    
    return self;
}


@end
