//
//  ConversationViewController.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatSessionInputBarControl.h"

@interface ChatConversationViewController : UIViewController
/** 会话人id,targetId */
@property (copy , nonatomic) NSString *targetId;
/** 回话页面视图 - 消息展示视图*/
@property (strong , nonatomic, readonly) UITableView *tableView;
/** 聊天会话-输入视图 */
@property (strong , nonatomic) ChatSessionInputBarControl *chatSessionInputBarControl;



#pragma mark - UI界面API

/*!
 注册自定义消息的Cell
 
 @param cellClass      自定义消息Cell对应的自定义消息，该自定义Cell继承自ChatMessageBaseCell
 @param messageClass   自定义消息的类，该自定义消息需要继承于ChatMessageContent
 */
- (void)registerClass:(Class)cellClass forMessageClass:(Class)messageClass;

/*!
 滚动到列表最下方
 
 @param animated 是否开启动画效果
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 停止编辑
 */
- (void)endEditing;

#pragma mark - 发送消息API

- (void)sendTextMessage:(NSString *)text;



@end




