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

 - ChatEmojiItemTypeEmoji: 表情emji
 - ChatEmojiItemTypeBackspace: 退格键
 */
typedef NS_ENUM(NSInteger, ChatEmojiItemType)
{
    ChatEmojiItemTypeEmoji,
    ChatEmojiItemTypeBackspace
};

@interface ChatEmojiItem : NSObject
/** emoji 编码 */
@property (copy , nonatomic) NSString *emojiEncode;
/** item 类型 */
@property (assign , nonatomic) ChatEmojiItemType type;

/**
 创建item

 @param encode 编码
 @param type 类型
 @return EmojiItem
 */
+ (instancetype)emojiWithEncode:(NSString *)encode type:(ChatEmojiItemType)type;

@end



