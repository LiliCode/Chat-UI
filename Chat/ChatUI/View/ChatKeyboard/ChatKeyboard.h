//
//  ChatKeyboard.h
//  Chat
//
//  Created by 李立 on 2017/10/25.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatKeyboard : UIView
/** UITextField输入框 */
@property (weak, nonatomic) UITextField *textField;
/** UITextView输入框 */
@property (weak, nonatomic) UITextView *textView;


/**
 初始化方法

 @param textField 设置当前键盘的输入对象-UITextField
 @return 返回自定义键盘
 */
- (instancetype)initWithTextField:(UITextField *)textField;

/**
 初始化方法
 
 @param textView 设置当前键盘的输入对象-UITextView
 @return 返回自定义键盘
 */
- (instancetype)initWithTextView:(UITextView *)textView;

@end



