//
//  MessageContent.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

@protocol MessageContentDelegate <NSObject>
@required

/**
 根据消息内容获取消息的尺寸大小

 @return 返回 CGSize结构体
 */
- (CGSize)getMessageContentSize;

@end

@interface MessageContent : NSObject<MessageContentDelegate>
/** 消息类型名称 - 派生类需要重写getter方法 */
@property (copy, nonatomic, readonly) NSString *objectName;
/** 消息尺寸：文本消息动态计算 */
@property (assign, nonatomic) CGSize contentSize;



@end




