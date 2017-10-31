//
//  UserInfo.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithUserId:(NSString *)userId withName:(NSString *)name withLogo:(NSString *)logo
{
    if (self = [super init])
    {
        self.userId = userId;
        self.name = name;
        self.userLogo = logo;
    }
    
    return self;
}

@end
