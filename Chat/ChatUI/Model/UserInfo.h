//
//  UserInfo.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/** 用户名称 */
@property (copy , nonatomic) NSString *name;
/** 用户id */
@property (copy , nonatomic) NSString *userId;
/** 用户头像 */
@property (copy , nonatomic) NSString *userLogo;


/**
 自定义构造方法

 @param userId 用户id
 @param name 名称
 @param logo 头像
 @return 返回 UserInfo
 */
- (instancetype)initWithUserId:(NSString *)userId withName:(NSString *)name withLogo:(NSString *)logo;

@end
