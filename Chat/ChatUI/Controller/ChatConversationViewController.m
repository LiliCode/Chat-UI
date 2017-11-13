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
#import "ChatMessageImageCell.h"

#import <Masonry.h>
#import <TZImagePickerController.h>
#import <UITableView+FDTemplateLayoutCell.h>


@interface ChatConversationViewController ()<UITableViewDataSource, UITableViewDelegate, ChatTableViewDelegate, ChatSessionInputBarControlDelegate>
@property (strong, nonatomic) ChatTableView *conversationTableView;
@property (strong, nonatomic) ChatSessionInputBarControl *inputBarControl;
/** 消息注册表 */
@property (strong, nonatomic) NSMutableDictionary *registerCellTable;
/** 消息列表 */
@property (strong, nonatomic) NSMutableArray *messageList;


@end

@implementation ChatConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.messageList = [[NSMutableArray alloc] init];
    self.registerCellTable = [[NSMutableDictionary alloc] init];
    
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
        [self selectImage];
    }];
    
    ChatPluginItem *cameraPluginItem = [ChatPluginItem pluginItemWithTitle:@"相机" image:kChatFcuntionView_PluginButtonCamera callback:^(id sender) {
        NSLog(@"点击了相机");
    }];
    
    [self.chatSessionInputBarControl insertPluginItem:imagePluginItem];
    [self.chatSessionInputBarControl insertPluginItem:cameraPluginItem];
    
    // 注册消息
    // text
    [self registerClass:[ChatMessageTextCell class] forMessageClass:[ChatTextMessageContent class]];
    // image
    [self registerClass:[ChatMessageImageCell class] forMessageClass:[ChatImageMessageContent class]];
    
    
    
    
    self.conversationTableView.backgroundColor = rgbColor(235.0f, 235.0f, 235.0f, 1);
    [self.tableView setTableFooterView:[UIView new]];
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
    // 获取消息
    ChatMessage *msg = [self.messageList objectAtIndex:indexPath.row];
    // 用消息类在注册表中找到相应的Cell类名称
    NSString *cellClassName = [self.registerCellTable objectForKey:NSStringFromClass([msg.messageContent class])];
    // 计算高度
    return [tableView fd_heightForCellWithIdentifier:cellClassName cacheByIndexPath:indexPath configuration:^(ChatMessageBaseCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取消息
    ChatMessage *msg = [self.messageList objectAtIndex:indexPath.row];
    // 用消息类在注册表中找到相应的Cell类名称
    NSString *cellClassName = [self.registerCellTable objectForKey:NSStringFromClass([msg.messageContent class])];
    Class cellClass = NSClassFromString(cellClassName);
    ChatMessageBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassName];
    }
    
    cell.messageModel = msg;    // 设置消息
    
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

    [self sendTextMessage:text];
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

- (void)functionViewDidShowWithInputBarControl:(ChatSessionInputBarControl *)bar
{
    [self.conversationTableView scrollToBottomAnimated:YES];
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


- (void)selectImage
{
    TZImagePickerController *pickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    pickerController.allowPreview = YES;
    [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
        [self sendImageMessage:assets.firstObject];
    }];

    [self presentViewController:pickerController animated:YES completion:nil];
}


#pragma mark - 公共方法、暴露的接口方法

- (void)scrollToBottomAnimated:(BOOL)animated
{
    // 滚动
    [self.conversationTableView scrollToBottomAnimated:YES];
}

- (void)endEditing
{
    [self.inputBarControl endInputing];
}

- (void)registerClass:(Class)cellClass forMessageClass:(Class)messageClass
{
    // 添加到注册表
    [self.registerCellTable setObject:NSStringFromClass(cellClass) forKey:NSStringFromClass(messageClass)];
    // 注册Cell
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)sendTextMessage:(NSString *)text
{
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
    [self.conversationTableView scrollToBottomAnimated:YES];
}

- (void)sendImageMessage:(PHAsset *)image
{
    ChatImageMessageContent *imageContent = [[ChatImageMessageContent alloc] init];
    imageContent.image = image;
    
    ChatUserInfo *user = [[ChatUserInfo alloc] init];
    user.name = @"Lili";
    user.userId = @"17713582481";
    user.userLogo = @"avatar-2";
    
    ChatMessage *imageMessage = [[ChatMessage alloc] initWithTargetId:@"18281863522" direction:ChatMessageDirection_send content:imageContent];
    imageMessage.senderUserInfo = user;
    
    [self.messageList addObject:imageMessage];
    [self.tableView reloadData];
    
    [self.conversationTableView scrollToBottomAnimated:YES];
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





