//
//  ConversationViewController.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ConversationViewController.h"
#import "ChatPluginBoardView.h"
#import "ChatEmojiBoardView.h"
#import "UIView+ChatFrame.h"
#import <Masonry.h>


@interface ConversationViewController ()<UITableViewDataSource, UITableViewDelegate, ChatSessionInputBarControlDelegate>
@property (strong, nonatomic) UITableView *conversationTableView;
@property (strong, nonatomic) ChatSessionInputBarControl *inputBarControl;
@property (strong, nonatomic) UIView *pluginBGView; // emoji, plugin背景
/** 消息列表 */
@property (strong, nonatomic) NSMutableArray *messageList;

@end

@implementation ConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.messageList = [[NSMutableArray alloc] init];
    
    [self prepare];
    
}

- (void)prepare
{
    // 创建tableView
    self.conversationTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // 无Cell线条
    [self.conversationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 代理
    self.conversationTableView.delegate = self;
    self.conversationTableView.dataSource = self;
    // 输入视图
    self.inputBarControl = [[ChatSessionInputBarControl alloc] init];
    self.inputBarControl.delegate = self;
    // 键盘背景
    self.pluginBGView = [[UIView alloc] init];
    self.pluginBGView.backgroundColor = [UIColor redColor];
    // 添加
    [self.view addSubview:self.conversationTableView];
    [self.view addSubview:self.inputBarControl];
    [self.view addSubview:self.pluginBGView];
    
    __weak typeof(self) weakSelf = self;
    
    [self.pluginBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(0);  // 初始高度 0
    }];
    
    [self.inputBarControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0).offset(0);
        make.right.mas_equalTo(0).offset(0);
        make.bottom.equalTo(weakSelf.pluginBGView.mas_top).offset(0);
        make.height.mas_equalTo(0).offset(kChatInputBarContentHeight);
    }];
    
    [self.conversationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0).offset(0);
        make.left.mas_equalTo(0).offset(0);
        make.right.mas_equalTo(0).offset(0);
        make.bottom.equalTo(weakSelf.inputBarControl.mas_top).offset(0);
    }];
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}




#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)sender
{
    // 键盘将要弹起
    // 获取参数
    // 尺寸
    CGRect bounds = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时长
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 改变约束
        [self.pluginBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(bounds.size.height);
        }];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    // 键盘将要隐藏
    // 动画时长
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 改变约束
        [self.pluginBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 + UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [self.messageList objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma ChatSessionInputBarControlDelegate

- (void)inputBarControl:(ChatSessionInputBarControl *)bar clickSend:(NSString *)text
{
    NSLog(@"send: {\"text\":\"%@\"}", text);
    [self.messageList addObject:text];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.messageList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)inputBarControl:(ChatSessionInputBarControl *)bar didSelectPlugin:(NSInteger)index
{
    NSLog(@"click plugin: %ld", index);
}

- (void)openPluginKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    CGRect frame = CGRectMake(0, 0, self.view.width, kChatPluginKeyboardHeight);
    NSNotification *noti = [NSNotification notificationWithName:UIKeyboardWillShowNotification object:nil userInfo:@{UIKeyboardFrameEndUserInfoKey:[NSValue valueWithCGRect:frame], UIKeyboardAnimationDurationUserInfoKey:@.3}];
    [self keyboardWillShow:noti];
}

- (void)openEmojiKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    CGRect frame = CGRectMake(0, 0, self.view.width, kChatEmojiKeyboardHeight);
    NSNotification *noti = [NSNotification notificationWithName:UIKeyboardWillShowNotification object:nil userInfo:@{UIKeyboardFrameEndUserInfoKey:[NSValue valueWithCGRect:frame], UIKeyboardAnimationDurationUserInfoKey:@.3}];
    [self keyboardWillShow:noti];
}




#pragma mark - getter setter

- (UITableView *)tableView
{
    return self.conversationTableView;
}

- (ChatSessionInputBarControl *)chatSessionInputBarControl
{
    return self.inputBarControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




@end





