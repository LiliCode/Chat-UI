//
//  ChatTableView.h
//  Chat
//
//  Created by 李立 on 2017/10/27.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatTableViewDelegate <NSObject>
@optional
- (void)clickTableView:(UITableView *)tableView;

@end

@interface ChatTableView : UITableView
/** ChatTableViewDelegate */
@property (weak, nonatomic) id<ChatTableViewDelegate> chatDelegate;


/**
 滚动到最底部

 @param animated 动画 - YES:执行动画
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

@end
