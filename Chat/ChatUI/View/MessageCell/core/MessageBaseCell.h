//
//  MessageBaseCell.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "ChatUI.h"

@interface MessageBaseCell : UITableViewCell
/** 头像 - logo*/
@property (strong , nonatomic, readonly) UIImageView *logoImageView;
/** 展示内容 - content view*/
@property (strong , nonatomic, readonly) UIView *messageContentView;
/** 数据模型 */
@property (strong , nonatomic) Message *messageModel;


/**
 初始化的时候调用
 */
- (void)prepare;

/**
 布局
 */
- (void)layoutMessage;



@end
