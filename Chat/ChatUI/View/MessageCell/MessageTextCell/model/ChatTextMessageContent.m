//
//  TextMessageContent.m
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatTextMessageContent.h"
#import "ChatUI.h"
#import "NSString+ChatUI.h"
#import <UIKit/NSAttributedString.h>
#import <UIKit/NSStringDrawing.h>

NSString *const CHATUI_TEXT_MESSAGE_CONTENT = @"ChatUI:textMsg";


/** 消息label顶部和底部距离contentView顶部和底部的距离之和：topMargin + bottomMargin */
static const CGFloat kMessageLabelTopAndBottomMargin = 10.0f;

/** 消息label顶部和底部距离contentView左边和右边的距离之和：leftMargin + rightMargin */
static const CGFloat kMessageLabelLeftAndRightMargin = 17.0f;

/** 消息气泡imageView距离contentView顶部和底部的距离之和：topMargin + bottomMargin */
static const CGFloat kMessageBubbleTopAndBottomMargin = 20.0f;


@implementation ChatTextMessageContent


- (void)setText:(NSString *)text
{
    _text = text;
    
    // 计算尺寸
    if (CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        self.contentSize = [self getMessageContentSize];
    }
}

- (CGSize)getMessageContentSize
{
    // 计算文本尺寸
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake([ChatUI sharedUI].globalMessageContentViewMaxWidth - kMessageLabelLeftAndRightMargin, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[ChatUI sharedUI].globalMessageTextFont} context:nil].size;
    // 计算需要展示的尺寸
    CGSize size = CGSizeZero;
    // left + right margin
    size.width = ceil(textSize.width + kMessageLabelLeftAndRightMargin);
    size.height = ceil(MAX(textSize.height + kMessageLabelTopAndBottomMargin, [ChatUI sharedUI].globalMessagePortraitSize.height) + kMessageBubbleTopAndBottomMargin);
    
    return size;
}

- (NSString *)objectName
{
    return CHATUI_TEXT_MESSAGE_CONTENT;
}

@end




