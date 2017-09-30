//
//  ConversationViewController.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatSessionInputBarControl.h"

@interface ConversationViewController : UIViewController
/** 回话页面视图 - 消息展示视图*/
@property (strong, nonatomic, readonly) UITableView *tableView;
/** 聊天会话-输入视图 */
@property (strong, nonatomic) ChatSessionInputBarControl *chatSessionInputBarControl;



@end
