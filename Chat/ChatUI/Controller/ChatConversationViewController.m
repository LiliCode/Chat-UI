//
//  ConversationViewController.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatConversationViewController.h"
#import "ChatMessageCommon.h"
#import "ChatTableView.h"
#import "UIView+ChatUI.h"
#import "UIColor+ChatUI.h"
#import "ChatMessageTextCell.h"

#import <Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>


@interface ChatConversationViewController ()<UITableViewDataSource, UITableViewDelegate, ChatTableViewDelegate, ChatSessionInputBarControlDelegate>
@property (strong, nonatomic) ChatTableView *conversationTableView;
@property (strong, nonatomic) ChatSessionInputBarControl *inputBarControl;
/** 消息列表 */
@property (strong, nonatomic) NSMutableArray *messageList;


@end

@implementation ChatConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.messageList = [[NSMutableArray alloc] init];
    
    [self prepare];
}

- (void)prepare
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建tableView
    self.conversationTableView = [[ChatTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.conversationTableView.chatDelegate = self;
    // 无Cell线条
    [self.conversationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 代理
    self.conversationTableView.delegate = self;
    self.conversationTableView.dataSource = self;
    // 输入视图
    self.inputBarControl = [[ChatSessionInputBarControl alloc] init];
    self.inputBarControl.delegate = self;
    // 添加
    [self.view addSubview:self.conversationTableView];
    [self.view addSubview:self.inputBarControl];
    [self.view addSubview:self.inputBarControl];
    
    __weak typeof(self) weakSelf = self;
    
    [self.inputBarControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.mas_equalTo(0);
        // 大于或等于 kChatInputBarContentHeight
        make.height.mas_greaterThanOrEqualTo(kChatInputBarContentHeight);
    }];

    [self.conversationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.bottom.equalTo(weakSelf.inputBarControl.mas_top).offset(0);
    }];
    // 添加手势 - window
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.conversationTableView addGestureRecognizer:tap];
    
    // add plugin
    ChatPluginItem *imagePluginItem = [ChatPluginItem pluginItemWithTitle:@"图片" image:kChatFcuntionView_PluginButtonImage callback:^(id sender) {
        NSLog(@"点击了图片");
    }];
    
    ChatPluginItem *cameraPluginItem = [ChatPluginItem pluginItemWithTitle:@"相机" image:kChatFcuntionView_PluginButtonCamera callback:^(id sender) {
        NSLog(@"点击了相机");
    }];
    
    [self.chatSessionInputBarControl insertPluginItem:imagePluginItem];
    [self.chatSessionInputBarControl insertPluginItem:cameraPluginItem];
    
    
    self.conversationTableView.backgroundColor = rgbColor(235.0f, 235.0f, 235.0f, 1);
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerClass:[ChatMessageTextCell class] forCellReuseIdentifier:NSStringFromClass([ChatMessageTextCell class])];
    
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
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ChatMessageTextCell class]) cacheByIndexPath:indexPath configuration:^(ChatMessageBaseCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessageTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChatMessageTextCell class]) forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ChatMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//    cell.fd_enforceFrameLayout = NO;    // 开启强制布局
    ChatMessage *msg = [self.messageList objectAtIndex:indexPath.row];
    cell.messageModel = msg;
}


#pragma mark - ChatTableViewDelegate

- (void)clickTableView:(UITableView *)tableView
{
    [self endEditing];
}

#pragma mark - ChatSessionInputBarControlDelegate

- (void)inputBarControl:(ChatSessionInputBarControl *)bar clickSend:(NSString *)text
{
    NSLog(@"send: {\"text\":\"%@\"}", text);
    
    ChatMessage *messageItem = [[ChatMessage alloc] init];
    ChatTextMessageContent *textContent = [[ChatTextMessageContent alloc] init];
    textContent.text = text;
    messageItem.messageContent = textContent;
    messageItem.direction = self.messageList.count % 2;
    ChatUserInfo *user = [[ChatUserInfo alloc] init];
    if (messageItem.direction)
    {
        user.name = @"Lili";
        user.userId = @"18281863522";
        user.userLogo = @"avatar-1";
    }
    else
    {
        user.name = @"Donglinglai";
        user.userId = @"17713582481";
        user.userLogo = @"avatar-2";
    }
    messageItem.senderUserInfo = user;
    
    [self.messageList addObject:messageItem];
    [self.tableView reloadData];
    // 滚动
    [self scrollToBottomAnimated:YES];
}

- (void)inputBarControl:(ChatSessionInputBarControl *)bar didSelectPlugin:(NSInteger)index
{
    NSLog(@"click plugin: %ld", index);
}

- (void)openPluginKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    
}

- (void)openEmojiKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    
}

- (void)openSystemKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    // 显示系统键盘
    [self.chatSessionInputBarControl beginInputing];
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

#pragma mark - 公共方法、暴露的接口方法

- (void)endEditing
{
    [self.inputBarControl endInputing];
}

- (void)sendTextMessage:(NSString *)text
{
    
}


- (void)scrollToBottomAnimated:(BOOL)animated
{
    CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    if (self.conversationTableView.contentSize.height > self.conversationTableView.bounds.size.height - 64)
    {
        yOffset = self.conversationTableView.contentSize.height - self.conversationTableView.bounds.size.height + 64;
        [self.conversationTableView setContentOffset:CGPointMake(0, yOffset) animated:animated];
    }
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    NSLog(@"[%s] %@ -> free", __FILE__, NSStringFromClass(self.class));
}


@end





