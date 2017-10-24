//
//  PluginItem.h
//  Chat
//
//  Created by 李立 on 2017/10/24.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PluginItemCallback)(id sender);

@interface PluginItem : NSObject
/** 标题 */
@property (copy , nonatomic) NSString *title;
/** 图标 */
@property (copy , nonatomic) NSString *image;
/** 回调方法 */
@property (strong , nonatomic) PluginItemCallback callback;


/**
 创建一个plugin模型

 @param title 标题
 @param image 图标
 @param callback 回调块
 @return 返回plugin
 */
+ (instancetype)pluginItemWithTitle:(NSString *)title image:(NSString *)image callback:(PluginItemCallback)callback;

@end


