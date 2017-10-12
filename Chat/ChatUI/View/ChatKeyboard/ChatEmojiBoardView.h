//
//  ChatEmojiBoardView.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>



UIKIT_EXTERN const CGFloat kChatEmojiKeyboardHeight;


@class ChatEmojiBoardView;
@protocol ChatEmojiBoardViewDelegate <NSObject>
@optional

/**
 点击了emoji表情

 @param emojiView ChatEmojiBoardView
 @param emoji 表情文字
 */
- (void)emojiBoardView:(ChatEmojiBoardView *)emojiView clickEmoji:(NSString *)emoji;

/**
 点击退格键-删除最后一个表情文字

 @param emojiView ChatEmojiBoardView
 */
- (void)clickBackspaceWithEmojiBoardView:(ChatEmojiBoardView *)emojiView;

/**
 点击发送按钮

 @param emojiView ChatEmojiBoardView
 */
- (void)clickSendWithEmojiBoardView:(ChatEmojiBoardView *)emojiView;

@end


/**
 表情视图
 */
@interface ChatEmojiBoardView : UIView
/** 代理对象 */
@property (weak, nonatomic) id<ChatEmojiBoardViewDelegate> delegate;

@end




