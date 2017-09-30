//
//  ChatSessionInputBarControl.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>


FOUNDATION_EXTERN CGFloat const kChatInputBarContentHeight;


@class ChatSessionInputBarControl;
@protocol ChatSessionInputBarControlDelegate <NSObject>
@optional

/**
 点击了键盘的确定按钮或者发送按钮

 @param bar ChatSessionInputBarControl
 @param text 输入的文本文字（text，emoji）
 */
- (void)inputBarControl:(ChatSessionInputBarControl *)bar clickSend:(NSString *)text;

/**
 点击扩展板中的按钮

 @param bar ChatSessionInputBarControl
 @param index 扩展板的编号
 */
- (void)inputBarControl:(ChatSessionInputBarControl *)bar didSelectPlugin:(NSInteger)index;

@end



/**
 页面输入视图-输入框-emoji-plugin
 */
@interface ChatSessionInputBarControl : UIView
/** 代理对象 */
@property (weak, nonatomic) id<ChatSessionInputBarControlDelegate> delegate;


@end




