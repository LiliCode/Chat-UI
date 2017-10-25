//
//  ChatSessionInputBarControl.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatSessionInputBarControl.h"
#import "MessageCommon.h"
#import <Masonry.h>

const CGFloat kChatInputBarContentHeight = 50.0f;

static CGFloat kTextViewTop = 8.0f;
static CGFloat kTextViewBottom = 8.0f;

@interface ChatSessionInputBarControl ()<UITextViewDelegate>
/** text view */
@property (strong , nonatomic) UITextView *textView;
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

- (void)setText:(NSString *)text
{
    self.textView.text = text;
}

- (NSString *)text
{
    return self.textView.text;
}

- (UITextView *)inputTextView
{
    return self.textView;
}

- (void)prepare
{
    // UI
    self.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1];
    
    // 插件入口 plugin
    UIButton *pluginButton = [[UIButton alloc] init];
    [pluginButton addTarget:self action:@selector(openPlugin:) forControlEvents:UIControlEventTouchUpInside];
    [pluginButton setImage:[UIImage imageNamed:kInputControl_PluginButtonNormal] forState:UIControlStateNormal];
    [pluginButton setImage:[UIImage imageNamed:kInputControl_PluginButtonHighlighted] forState:UIControlStateNormal];
    [self addSubview:pluginButton];
    [pluginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.bottom.mas_offset(-kTextViewBottom);
        make.width.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
        make.height.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
    }];
    
    // 表情键盘 emoji
    UIButton *emojiButton = [[UIButton alloc] init];
    [emojiButton addTarget:self action:@selector(openEmoji:) forControlEvents:UIControlEventTouchUpInside];
    [emojiButton setImage:[UIImage imageNamed:kInputControl_EmojiButtonNormal] forState:UIControlStateNormal];
    [emojiButton setImage:[UIImage imageNamed:kInputControl_EmojiButtonHighlighted] forState:UIControlStateNormal];
    [self addSubview:emojiButton];
    [emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pluginButton.mas_left).offset(0);
        make.bottom.mas_offset(-kTextViewBottom);
        make.width.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
        make.height.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
    }];
    
    // 手写输入键盘
    UIButton *penButton = [[UIButton alloc] init];
    [penButton addTarget:self action:@selector(penAction:) forControlEvents:UIControlEventTouchUpInside];
    [penButton setImage:[UIImage imageNamed:kInputControl_PenButtonNormal] forState:UIControlStateNormal];
    [penButton setImage:[UIImage imageNamed:kInputControl_PenButtonHighlighted] forState:UIControlStateNormal];
    [self addSubview:penButton];
    [penButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.bottom.mas_offset(-kTextViewBottom);
        make.width.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
        make.height.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
    }];
    
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
        make.left.equalTo(penButton.mas_right).offset(8);
        make.right.equalTo(emojiButton.mas_left).offset(-8);
        make.bottom.mas_offset(-kTextViewBottom);
        make.height.mas_greaterThanOrEqualTo(kChatInputBarContentHeight-16);
    }];
    
    
    // 监听文本输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    self.textViewLastHeight = kChatInputBarContentHeight;   // 初始值
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

- (void)textDidChange
{
    [self textDidChange:nil];   // 改变文字输入框的高度
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
            // 更新键盘尺寸
            [self textDidChange:nil];
        }
        
        return NO;
    }
    
    return YES;
}


#pragma mark - plugin action

- (void)openPlugin:(UIButton *)sender
{
    [self.textView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(openPluginKeyboardWithInputBarControl:)])
    {
        [self.delegate openPluginKeyboardWithInputBarControl:self];
    }
}

#pragma mark - emoji action

- (void)openEmoji:(UIButton *)sender
{
    [self.textView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(openEmojiKeyboardWithInputBarControl:)])
    {
        [self.delegate openEmojiKeyboardWithInputBarControl:self];
    }
}

#pragma mark - 手写笔

- (void)penAction:(UIButton *)sender
{
    NSLog(@"打开笔输入...");
}


#pragma mark - memory

- (void)dealloc
{
    
}



@end







