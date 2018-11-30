//
//  ChatUI.h
//  Chat
//
//  Created by 李立 on 2017/10/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIFont.h>
#import <UIKit/UIColor.h>

/*!
 头像显示的形状
 */
typedef NS_ENUM(NSInteger, ChatUserAvatarStyle)
{
    /*! 矩形 */
    ChatUserAvatarStyleRectangle = 0,
    /*! 圆形 */
    ChatUserAvatarStyleCycle
};


/**
 管理Chat的全局UI配置类
 */
@interface ChatUI : NSObject<NSCopying, NSMutableCopying>

/*!
 会话列表界面中显示的头像大小，高度必须大于或者等于36
 
 @discussion 默认值为46*46
 */
@property(nonatomic) CGSize globalConversationPortraitSize;

/*!
 SDK会话页面中显示的头像形状，矩形或者圆形
 
 @discussion 默认值为矩形，即RC_USER_AVATAR_RECTANGLE
 */
@property(nonatomic) ChatUserAvatarStyle globalMessageAvatarStyle;

/*!
 SDK会话页面中显示的头像大小
 
 @discussion 默认值为40*40
 */
@property(nonatomic) CGSize globalMessagePortraitSize;

/*!
 SDK会话列表界面和会话页面的头像的圆角曲率半径
 
 @discussion 默认值为4，只有当头像形状设置为矩形时才会生效。
 */
@property(nonatomic) CGFloat portraitImageViewCornerRadius;

/**
 全局消息字体
 
 @discussion 默认字体大小14 systemFont
 */
@property (strong, nonatomic) UIFont *globalMessageTextFont;

/**
 全局消息的颜色
 
 @discussion 默认颜色黑色
 */
@property (strong, nonatomic) UIColor *globalMessageTextColor;

/**
 全局消息Cell最大宽度
 
 @discussion 默认250.0f
 */
@property (assign, nonatomic) CGFloat globalMessageContentViewMaxWidth;

/**
 图片消息中图片的展示尺寸
 
 @discussion 默认 150 * 150
 */
@property (assign, nonatomic) CGSize globalMessageImageSize;




/**
 全局配置对象

 @return ChatUI 静态实例类对象
 */
+ (instancetype)sharedUI;




@end
