//
//  ChatSessionInputBarControl.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatSessionInputBarControl.h"
#import "ChatMessageCommon.h"
#import "UIColor+ChatUI.h"
#import <Masonry.h>

const CGFloat kChatInputBarContentHeight = 50.0f;
const CGFloat kChatInputBarContentMaxHeight = 100.0f;

static CGFloat kTextViewTop = 8.0f;
static CGFloat kTextViewBottom = 8.0f;

@interface ChatSessionInputBarControl ()<UITextViewDelegate, ChatEmojiBoardViewDelegate>
/** text view */
@property (strong , nonatomic) UITextView *textView;
/** input bar 背景视图 */
@property (strong , nonatomic) UIView *inputBarBGView;
/** Emoji and Plugin 背景视图 */
@property (strong , nonatomic) UIView *functionView;
/** 扩展板类型 */
@property (assign , nonatomic) ChatFunctionViewShowType functionType;
/** 扩展板的高度 */
@property (assign , nonatomic) CGFloat functionViewHeight;
/** 扩展板约束动画时长 */
@property (assign , nonatomic) CGFloat functionViewAnimationDuration;
/** 插件键盘 */
@property (strong, nonatomic) ChatPluginBoardView *pluginKeyboard;
/** 表情键盘 */
@property (strong, nonatomic) ChatEmojiBoardView *emojiKeyboard;
/** 点击插件的按钮 */
@property (strong, nonatomic) UIButton *pluginButton;
/** 点击表情的按钮 */
@property (strong, nonatomic) UIButton *emojiButton;


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

- (ChatFunctionViewShowType)functionKeyboardType
{
    return self.functionType;
}

- (ChatPluginBoardView *)pluginKeyboard
{
    if (!_pluginKeyboard)
    {
        _pluginKeyboard = [[ChatPluginBoardView alloc] init];
    }
    
    return _pluginKeyboard;
}

- (ChatEmojiBoardView *)emojiKeyboard
{
    if (!_emojiKeyboard)
    {
        _emojiKeyboard = [[ChatEmojiBoardView alloc] init];
    }
    
    return _emojiKeyboard;
}

- (void)drawLine
{
    // line
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = rgbColor(220, 220, 221, 1);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_offset(0);
        make.height.mas_offset(0.3);
    }];
}

- (void)prepare
{
    __weak typeof(self) weakSelf = self;
    self.inputBarMaxHeight = kChatInputBarContentMaxHeight;
    // 顶部线条
    [self drawLine];
    // UI - #F4F4F6
    self.backgroundColor = rgbColor(244.0f, 244.0f, 246.0f, 1);
    // input bar bg
    self.inputBarBGView = [[UIView alloc] init];
    self.inputBarBGView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.inputBarBGView];
    [self.inputBarBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.mas_equalTo(0);
        make.height.mas_equalTo(kChatInputBarContentHeight);
    }];
    // 插件入口 plugin
    self.pluginButton = [[UIButton alloc] init];
    self.pluginButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [self.pluginButton addTarget:self action:@selector(openPlugin:) forControlEvents:UIControlEventTouchUpInside];
    [self.pluginButton setImage:[UIImage imageNamed:kInputControl_PluginButtonNormal] forState:UIControlStateNormal];
    [self.pluginButton setImage:[UIImage imageNamed:kInputControl_PluginButtonHighlighted] forState:UIControlStateNormal];
    [self.inputBarBGView addSubview:self.pluginButton];
    [self.pluginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.bottom.mas_offset(-kTextViewBottom);
        make.width.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
        make.height.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
    }];
    
    // 表情键盘 emoji
    self.emojiButton = [[UIButton alloc] init];
    self.emojiButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [self.emojiButton addTarget:self action:@selector(openEmoji:) forControlEvents:UIControlEventTouchUpInside];
    [self.emojiButton setImage:[UIImage imageNamed:kInputControl_EmojiButtonNormal] forState:UIControlStateNormal];
    [self.emojiButton setImage:[UIImage imageNamed:kInputControl_EmojiButtonHighlighted] forState:UIControlStateNormal];
    [self.inputBarBGView addSubview:self.emojiButton];
    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.pluginButton.mas_left).offset(0);
        make.bottom.mas_offset(-kTextViewBottom);
        make.width.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
        make.height.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
    }];
    
    // 手写输入键盘
    UIButton *penButton = [[UIButton alloc] init];
    penButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [penButton addTarget:self action:@selector(penAction:) forControlEvents:UIControlEventTouchUpInside];
    [penButton setImage:[UIImage imageNamed:kInputControl_VoiceButtonNormal] forState:UIControlStateNormal];
    [penButton setImage:[UIImage imageNamed:kInputControl_VoiceButtonHighlighted] forState:UIControlStateNormal];
    [self.inputBarBGView addSubview:penButton];
    [penButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.bottom.mas_offset(-kTextViewBottom);
        make.width.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
        make.height.mas_offset(kChatInputBarContentHeight - 2 * kTextViewBottom);
    }];
    
    // text view
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.scrollEnabled = YES;
    self.textView.layer.borderColor = [rgbColor(220, 220, 221, 1) CGColor];
    self.textView.layer.borderWidth = .5f;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    [self.inputBarBGView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kTextViewTop);
        make.left.equalTo(penButton.mas_right).offset(8);
        make.right.equalTo(weakSelf.emojiButton.mas_left).offset(-8);
        make.bottom.mas_offset(-kTextViewBottom);
        make.height.mas_greaterThanOrEqualTo(kChatInputBarContentHeight-16);
    }];

    // 功能板 - function view
    self.functionView = [[UIView alloc] init];
    [self addSubview:self.functionView];
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.inputBarBGView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];

    // emoji
    [self.functionView addSubview:self.emojiKeyboard];
    [self.emojiKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    self.emojiKeyboard.hidden = YES;
    self.emojiKeyboard.delegate = self;
    
    // plugin
    [self.functionView addSubview:self.pluginKeyboard];
    [self.pluginKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    self.pluginKeyboard.hidden = YES;

    // 监听文本输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setFunctionType:(ChatFunctionViewShowType)functionType
{
    _functionType = functionType;
    
    [self showFunctionViewWithType:functionType];
}

#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)sender
{
    // 尺寸
    CGRect bounds = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!bounds.size.height)
    {
        return;     // 防止搜狗输入法调用多次引发的跳动问题
    }
    
    self.functionViewHeight = bounds.size.height;
    // 动画时长
    CGFloat duration = (CGFloat)[sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.functionViewAnimationDuration = duration;
    // 功能板显示成键盘
    self.functionType = ChatFunctionViewShowTypeKeyboard;
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    if (ChatFunctionViewShowTypeNothing != self.functionType && ChatFunctionViewShowTypeKeyboard != self.functionType)
    {
        return; // 防止emoji、plugin打开是存在跳动，解决搜狗输入法跳动问题
    }
    
    // 动画时长
    CGFloat duration = (CGFloat)[sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.functionViewAnimationDuration = duration;
    // 高度
    self.functionViewHeight = 0;
    // 功能板隐藏
    self.functionType = ChatFunctionViewShowTypeNothing;
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
    CGFloat inputBarHeight = MIN(self.inputBarMaxHeight, newSize.height);
    [self.inputBarBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(inputBarHeight + kTextViewTop + kTextViewBottom);
    }];

    [UIView animateWithDuration:.2 animations:^{
        // tableView 和 InputBar keyboard 约束均要更新
        [((UIViewController *)self.delegate).view layoutIfNeeded];
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
            // 更新inputBar尺寸
            [self.inputBarBGView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kChatInputBarContentHeight);
            }];
            
            [self layoutIfNeeded];
        }
        
        return NO;
    }
    
    return YES;
}

#pragma mark - 功能板

/**
 展示扩展功能板

 @param type 功能板类型
 */
- (void)showFunctionViewWithType:(ChatFunctionViewShowType)type
{
    switch (type)
    {
        case ChatFunctionViewShowTypeEmoji:
            self.emojiKeyboard.hidden = NO;
            self.pluginKeyboard.hidden = YES;
            [self.functionView bringSubviewToFront:self.emojiKeyboard];
            if ([self.inputTextView isFirstResponder])
            {
                [self.inputTextView resignFirstResponder];
            }
            
            self.functionViewHeight = kChatEmojiKeyboardHeight;
            self.functionViewAnimationDuration = kChatEmojiKeyboardAnimationDuration;
            break;
        case ChatFunctionViewShowTypePlugin:
            self.emojiKeyboard.hidden = YES;
            self.pluginKeyboard.hidden = NO;
            [self.functionView bringSubviewToFront:self.pluginKeyboard];
            if ([self.inputTextView isFirstResponder])
            {
                [self.inputTextView resignFirstResponder];
            }
            
            self.functionViewHeight = kChatPluginKeyboardHeight;
            self.functionViewAnimationDuration = kChatPluginKeyboardAnimationDuration;
            break;
        case ChatFunctionViewShowTypeKeyboard:
            self.emojiKeyboard.hidden = YES;
            self.pluginKeyboard.hidden = YES;
            break;
        case ChatFunctionViewShowTypeNothing:
            self.emojiKeyboard.hidden = YES;
            self.pluginKeyboard.hidden = YES;
            if ([self.inputTextView isFirstResponder])
            {
                [self.inputTextView resignFirstResponder];
            }
            else
            {
                self.functionViewHeight = 0;
                self.functionViewAnimationDuration = kChatPluginKeyboardAnimationDuration;
            }
            break;
        
        default: break;
    }
    
    [self updateFunctionViewConstraints];
    
    if (type == ChatFunctionViewShowTypeNothing)
    {
        if ([self.delegate respondsToSelector:@selector(functionViewDidHideWithInputBarControl:)])
        {
            [self.delegate functionViewDidHideWithInputBarControl:self];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(functionViewDidShowWithInputBarControl:)])
        {
            [self.delegate functionViewDidShowWithInputBarControl:self];
        }
    }
}

/**
 更新约束
 */
- (void)updateFunctionViewConstraints
{
    // 改变 inputBar height
    __weak typeof (self) weakSelf = self;
    [self.functionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.functionViewHeight - SafeAreaBottomHeight);
    }];
    
    // 动画
    [UIView animateWithDuration:self.functionViewAnimationDuration animations:^{
        // tableView 和 InputBar keyboard 约束均要更新
        [((UIViewController *)self.delegate).view layoutIfNeeded];
    }];
}

#pragma mark - plugin action

- (void)openPlugin:(UIButton *)sender
{
    if (ChatFunctionViewShowTypePlugin != self.functionType)
    {
        self.functionType = ChatFunctionViewShowTypePlugin;
    }
    else
    {
        // 弹出键盘
        [self.inputTextView becomeFirstResponder];
    }

    if ([self.delegate respondsToSelector:@selector(openPluginKeyboardWithInputBarControl:)])
    {
        [self.delegate openPluginKeyboardWithInputBarControl:self];
    }
}

#pragma mark - emoji action

- (void)openEmoji:(UIButton *)sender
{
    if (ChatFunctionViewShowTypeEmoji != self.functionType)
    {
        self.functionType = ChatFunctionViewShowTypeEmoji;
    }
    else
    {
        // 弹出键盘
        [self.inputTextView becomeFirstResponder];
    }
    
    [sender setSelected:!sender.selected];
    
    if ([self.delegate respondsToSelector:@selector(openEmojiKeyboardWithInputBarControl:)])
    {
        [self.delegate openEmojiKeyboardWithInputBarControl:self];
    }
}

#pragma mark - 手写笔

- (void)penAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(openSystemKeyboardWithInputBarControl:)])
    {
        [self.delegate openSystemKeyboardWithInputBarControl:self];
    }
}

#pragma mark - ChatEmojiBoardViewDelegate

- (void)emojiBoardView:(ChatEmojiBoardView *)emojiView clickEmoji:(ChatEmojiItem *)emoji
{
    [self.inputTextView insertText:emoji.emojiEncode];
}


#pragma mark - public api

- (void)endInputing
{
    self.functionType = ChatFunctionViewShowTypeNothing;
}

- (void)beginInputing
{
    [self.textView becomeFirstResponder];
}

- (void)insertPluginItem:(ChatPluginItem *)item
{
    [self.pluginKeyboard insertPluginItem:item];
}

#pragma mark - memory

- (void)dealloc
{
    // 删除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}




@end







