//
//  ConversationViewController.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationViewController : UIViewController
/** 回话页面视图 - 消息展示视图*/
@property (strong, nonatomic, readonly) UITableView *tableView;

@end
