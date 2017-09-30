//
//  ChatSessionInputBarControl.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatSessionInputBarControl.h"
#import "ChatPluginBoardView.h"
#import "ChatEmojiBoardView.h"
#import <Masonry.h>

const CGFloat kChatInputBarContentHeight = 50.0f;

@interface ChatSessionInputBarControl ()<UITextViewDelegate, ChatEmojiBoardViewDelegate, ChatPluginBoardViewDelegate>
/** 文本输入栏 contentView */
@property (strong , nonatomic) UIView *inputContentView;
/** emoji 、plugin 栏 contentView */
@property (strong , nonatomic) UIView *pluginContentView;
/** text view */
@property (strong , nonatomic) UITextView *textView;
/** 键盘弹起标识 */
@property (assign , nonatomic) BOOL keyboardShow;

@end

@implementation ChatSessionInputBarControl

- (instancetype)init
{
    if (self = [super init])
    {
        [self prepare];
    }
    
    return self;
}

- (void)prepare
{
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // UI
    self.backgroundColor = [UIColor whiteColor];
    
    self.inputContentView = [[UIView alloc] init];
    self.inputContentView.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1];
    [self addSubview:self.inputContentView];
    __weak typeof (self) weakSelf = self;
    [self.inputContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.height.mas_offset(kChatInputBarContentHeight);
    }];
    
    // text view
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.font = [UIFont systemFontOfSize:16];
    [self.inputContentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.mas_offset(20);
        make.right.mas_offset(-50);
        make.bottom.mas_offset(-8);
    }];
    
}


#pragma mark - keyboard 

- (void)keyboardWillChangeFrame:(NSNotification *)sender
{
    // 键盘将要弹起
    self.keyboardShow = YES;
    // 获取参数
    // 尺寸
    CGRect bounds = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时长
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 改变约束
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(kChatInputBarContentHeight + bounds.size.height);
        }];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    // 键盘将要隐藏
    self.keyboardShow = NO;
    // 动画时长
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 改变约束
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(kChatInputBarContentHeight);
        }];
    }];
}


#pragma mark - memory

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



@end







