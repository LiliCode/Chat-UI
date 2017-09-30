//
//  ConversationViewController.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ConversationViewController.h"
#import "UIView+ChatFrame.h"
#import <Masonry.h>



static CGFloat kChatInputBarControlHeight = 60.0f;


@interface ConversationViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *conversationTableView;
@property (strong, nonatomic) ChatSessionInputBarControl *inputBarControl;

@end

@implementation ConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self prepare];
    
}

- (void)prepare
{
    // 创建tableView
    self.conversationTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // 无Cell线条
    [self.conversationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 输入视图
    self.inputBarControl = [[ChatSessionInputBarControl alloc] init];
    
    // 添加
    [self.view addSubview:self.conversationTableView];
    [self.view addSubview:self.inputBarControl];
    
    __weak typeof(self) weakSelf = self;
    
    [self.inputBarControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0).offset(0);
        make.right.mas_equalTo(0).offset(0);
        make.bottom.mas_equalTo(0).offset(0);
        make.height.mas_equalTo(0).offset(kChatInputBarControlHeight);
    }];
    
    [self.conversationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0).offset(0);
        make.left.mas_equalTo(0).offset(0);
        make.right.mas_equalTo(0).offset(0);
        make.bottom.equalTo(weakSelf.inputBarControl.mas_top).offset(0);
    }];
    
    
    
    self.conversationTableView.backgroundColor = [UIColor redColor];
    self.inputBarControl.backgroundColor = [UIColor greenColor];
}





#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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





