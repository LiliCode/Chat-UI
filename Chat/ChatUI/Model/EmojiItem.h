//
//  EmojiItem.h
//  Chat
//
//  Created by 李立 on 2017/10/20.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 emoji item 类型

 - EmojiItemType_emoji: 表情emji
 - EmojiItemType_backspace: 退格键
 */
typedef NS_ENUM(NSInteger, EmojiItemType)
{
    EmojiItemType_emoji,
    EmojiItemType_backspace
};

@interface EmojiItem : NSObject
/** emoji 编码 */
@property (copy , nonatomic) NSString *emojiEncode;
/** item 类型 */
@property (assign , nonatomic) EmojiItemType type;

/**
 创建item

 @param encode 编码
 @param type 类型
 @return EmojiItem
 */
+ (instancetype)emojiWithEncode:(NSString *)encode type:(EmojiItemType)type;

@end



