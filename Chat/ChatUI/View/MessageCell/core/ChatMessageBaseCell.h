//
//  MessageBaseCell.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"
#import "ChatUI.h"


@protocol ChatMessageCellDelegate <NSObject>
@optional

/**
 点击了头像

 @param userId 用户id
 */
- (void)didTapAvatar:(NSString *)userId;

/**
 点击了cell

 @param chatMessage 消息实体对象
 */
- (void)didTapMessageCell:(ChatMessage *)chatMessage;

@end

@interface ChatMessageBaseCell : UITableViewCell
/** 头像 - logo*/
@property (strong , nonatomic, readonly) UIImageView *logoImageView;
/** 展示内容 - content view*/
@property (strong , nonatomic, readonly) UIView *messageContentView;
/** 数据模型 */
@property (strong , nonatomic) ChatMessage *messageModel;
/** 代理对象 */
@property (weak , nonatomic) id<ChatMessageCellDelegate> delegate;


/**
 初始化的时候调用
 */
- (void)prepare;

/**
 布局
 */
- (void)layoutMessage;



@end
