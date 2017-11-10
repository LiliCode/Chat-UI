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




