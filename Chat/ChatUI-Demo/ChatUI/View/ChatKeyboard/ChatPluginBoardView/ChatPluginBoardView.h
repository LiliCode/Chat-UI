//
//  ChatPluginBoardView.h
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatKeyboard.h"
#import "ChatPluginItem.h"

UIKIT_EXTERN NSString * const kChatPluginKeyboardWillShowNotification;
UIKIT_EXTERN NSString * const kChatPluginKeyboardWillHideNotification;
UIKIT_EXTERN NSString * const kChatPluginKeyboardDidShowNotification;
UIKIT_EXTERN NSString * const kChatPluginKeyboardDidHideNotification;

UIKIT_EXTERN const CGFloat kChatPluginKeyboardHeight;
UIKIT_EXTERN const CGFloat kChatPluginKeyboardAnimationDuration;


@class ChatPluginBoardView;
@protocol ChatPluginBoardViewDelegate <NSObject>
@optional

/**
 点击了插件（plugin）

 @param pluginView ChatPluginBoardView
 @param index plugin的索引
 */
- (void)pluginBoardView:(ChatPluginBoardView *)pluginView didSelectPluginItemAtIndex:(NSInteger)index;

@end


/**
 扩展视图-例如：图片，相机，位置...
 */
@interface ChatPluginBoardView : ChatKeyboard
/** 代理对象 */
@property (weak, nonatomic) id<ChatPluginBoardViewDelegate> delegate;


/**
 插入plugin item

 @param item PluginItem
 */
- (void)insertPluginItem:(ChatPluginItem *)item;

/**
 刷新plugin
 */
- (void)reloadPlugins;

@end



