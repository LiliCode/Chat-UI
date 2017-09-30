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

static CGFloat kTextViewTop = 8.0f;
static CGFloat kTextViewBottom = 8.0f;

@interface ChatSessionInputBarControl ()<UITextViewDelegate, ChatEmojiBoardViewDelegate, ChatPluginBoardViewDelegate>
/** text view */
@property (strong , nonatomic) UITextView *textView;
/** 键盘弹起标识 */
@property (assign , nonatomic) BOOL keyboardShow;
/** 上一次文本输入框的高度 */
@property (assign , nonatomic) CGFloat textViewLastHeight;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // UI
    self.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1];
    
    // text view
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderColor = [[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1] CGColor];
    self.textView.layer.borderWidth = .5f;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kTextViewTop);
        make.left.mas_offset(20);
        make.right.mas_offset(-50);
        make.bottom.mas_offset(-kTextViewBottom);
        make.height.mas_greaterThanOrEqualTo(kChatInputBarContentHeight-16);
    }];
    
    // 监听文本输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    self.textViewLastHeight = kChatInputBarContentHeight;   // 初始值
}


#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)sender
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
            make.bottom.mas_offset(-bounds.size.height);
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
            make.bottom.mas_offset(0);
        }];
    }];
}

#pragma mark - UITextView notification

- (void)textDidChange:(NSNotification *)sender
{
    // 计算文字所占尺寸
    // 获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(self.textView.frame);
    CGSize newSize = [self.textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = self.textView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), newSize.height);
    // 改变高度约束
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newFrame.size.height + kTextViewTop + kTextViewBottom);
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        // 回车，发送
        if (textView.text.length)
        {
            if ([self.delegate respondsToSelector:@selector(inputBarControl:clickSend:)])
            {
                [self.delegate inputBarControl:self clickSend:textView.text];
            }
            
            self.textView.text = nil;
        }
        
        return NO;
    }
    
    return YES;
}


#pragma mark - memory

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



@end







