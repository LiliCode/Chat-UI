//
//  ChatService.m
//  Chat
//
//  Created by 唯赢 on 2018/8/3.
//  Copyright © 2018年 李立. All rights reserved.
//

#import "ChatService.h"

@implementation ChatService

static ChatService *service = nil;

+ (instancetype)sharedService {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[ChatService alloc] init];
    });
    
    return service;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t alloc_onceToken;
    dispatch_once(&alloc_onceToken, ^{
        service = [super allocWithZone:zone];
    });
    
    return service;
}

- (id)copyWithZone:(NSZone *)zone {
    return service;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return service;
}


- (void)sendMessage:(ChatMessage *)message callback:(void (^)(NSError *error))callback {
    
}

@end





