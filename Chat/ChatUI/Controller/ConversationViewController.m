//
//  ConversationViewController.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ConversationViewController.h"
#import "ChatTableView.h"
#import "ChatPluginBoardView.h"
#import "ChatEmojiBoardView.h"
#import "UIView+ChatFrame.h"
#import <Masonry.h>


@interface ConversationViewController ()<UITableViewDataSource, UITableViewDelegate, ChatTableViewDelegate, ChatSessionInputBarControlDelegate, ChatEmojiBoardViewDelegate>
@property (strong, nonatomic) ChatTableView *conversationTableView;
@property (strong, nonatomic) ChatSessionInputBarControl *inputBarControl;
/** 表情键盘背景视图 */
@property (strong, nonatomic) UIView *pluginBackgroundView;
/** 插件键盘 */
@property (strong, nonatomic) ChatPluginBoardView *pluginKeyboard;
@property (assign, nonatomic) BOOL isShowPluginKeyboard;
/** 表情键盘 */
@property (strong, nonatomic) ChatEmojiBoardView *emojiKeyboard;
@property (assign, nonatomic) BOOL isShowEmojiKeyboard;

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
    // emoji plugin 背景视图
    self.pluginBackgroundView = [[UIView alloc] init];
    self.pluginBackgroundView.backgroundColor = [UIColor whiteColor];
    // plugin
    self.pluginKeyboard = [[ChatPluginBoardView alloc] init];
    self.pluginKeyboard.bounds = CGRectMake(0, 0, self.view.width, kChatPluginKeyboardHeight);
    [self.pluginBackgroundView addSubview:self.pluginKeyboard];
    // emoji
    self.emojiKeyboard = [[ChatEmojiBoardView alloc] initWithTextView:self.inputBarControl.inputTextView];
    self.emojiKeyboard.bounds = CGRectMake(0, 0, self.view.width, kChatEmojiKeyboardHeight);
    self.emojiKeyboard.delegate = self;
    [self.pluginBackgroundView addSubview:self.emojiKeyboard];
    // 添加
    [self.view addSubview:self.conversationTableView];
    [self.view addSubview:self.inputBarControl];
    [self.view addSubview:self.pluginBackgroundView];
    
    __weak typeof(self) weakSelf = self;
    
    [self.pluginBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(0);
    }];
    
    [self.inputBarControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0).offset(0);
        make.right.mas_equalTo(0).offset(0);
        make.bottom.equalTo(weakSelf.pluginBackgroundView.mas_top).offset(0);
        make.height.mas_equalTo(0).offset(kChatInputBarContentHeight);
    }];
    
    [self.conversationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0).offset(0);
        make.left.mas_equalTo(0).offset(0);
        make.right.mas_equalTo(0).offset(0);
        make.bottom.equalTo(weakSelf.inputBarControl.mas_top).offset(0);
    }];
    
    [self.emojiKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
    }];
    
    [self.pluginKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
    }];

    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 添加插件
    PluginItem *photoLibItem = [PluginItem pluginItemWithTitle:@"图片" image:@"actionbar_picture_icon" callback:^(id sender) {
        NSLog(@"点击了图片plugin");
    }];
    
    PluginItem *cameraItem = [PluginItem pluginItemWithTitle:@"相机" image:@"actionbar_camera_icon" callback:^(id sender) {
        NSLog(@"点击了相机plugin");
    }];
    
    [self.pluginKeyboard insertPluginItem:photoLibItem];
    [self.pluginKeyboard insertPluginItem:cameraItem];
    
    // 添加手势 - window
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.conversationTableView addGestureRecognizer:tap];
    
    
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
    if (CGRectGetHeight(bounds) != CGRectGetHeight(self.pluginBackgroundView.bounds))
    {
        // 改变约束
        [self.pluginBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(bounds.size.height);
        }];
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];  // 如果约束有改变就更新布局
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    // 键盘将要隐藏
    // 动画时长
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (!self.isShowEmojiKeyboard && !self.isShowPluginKeyboard)
    {
        // 改变约束
        [self.pluginBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];  // 如果约束有改变就更新布局
        }];
    }
}

/**
 扩展板-emoji、plugin的高度

 @param height height
 */
- (void)pluginChangeHeight:(CGFloat)height
{
    // 改变约束
    [self.pluginBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(height);
    }];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:kChatKeyboardAnimationDuration animations:^{
        [self.view layoutIfNeeded];  // 如果约束有改变就更新布局
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

#pragma mark - ChatTableViewDelegate

- (void)clickTableView:(UITableView *)tableView
{
    [self endEditing];
}

#pragma mark - ChatSessionInputBarControlDelegate

- (void)inputBarControl:(ChatSessionInputBarControl *)bar clickSend:(NSString *)text
{
    NSLog(@"send: {\"text\":\"%@\"}", text);
    [self.messageList addObject:text];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.messageList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    // 滚动
    [self scrollToBottomAnimated:YES];
}

- (void)inputBarControl:(ChatSessionInputBarControl *)bar didSelectPlugin:(NSInteger)index
{
    NSLog(@"click plugin: %ld", index);
}

- (void)openPluginKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    [self.pluginBackgroundView bringSubviewToFront:self.pluginKeyboard];
    self.isShowPluginKeyboard = YES;
    [bar.inputTextView resignFirstResponder];
    // frame
    [self pluginChangeHeight:kChatEmojiKeyboardHeight];
}

- (void)openEmojiKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    [self.pluginBackgroundView bringSubviewToFront:self.emojiKeyboard];
    self.isShowEmojiKeyboard = YES;
    [bar.inputTextView resignFirstResponder];
    // frame
    [self pluginChangeHeight:kChatEmojiKeyboardHeight];
}

- (void)openSystemKeyboardWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    // 显示系统键盘
    [self.chatSessionInputBarControl.inputTextView becomeFirstResponder];
}

#pragma mark - ChatEmojiBoardViewDelegate

- (void)emojiBoardView:(ChatEmojiBoardView *)emojiView clickEmoji:(EmojiItem *)emoji
{
    NSLog(@"%@", emoji.emojiEncode);
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
    if (self.isShowEmojiKeyboard || self.isShowPluginKeyboard)
    {
        [self pluginChangeHeight:0];
    }
    
    self.isShowEmojiKeyboard = NO;
    self.isShowPluginKeyboard = NO;
    
    if ([self.inputBarControl.inputTextView isFirstResponder])
    {
        [self.view endEditing:YES];
    }
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end





