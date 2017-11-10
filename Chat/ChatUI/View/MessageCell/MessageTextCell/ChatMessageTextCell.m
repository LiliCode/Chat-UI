//
//  MessageTextCell.m
//  Chat
//
//  Created by 李立 on 2017/10/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageTextCell.h"
#import <Masonry.h>


@interface ChatMessageTextCell ()
/** 气泡图片 */
@property (strong , nonatomic) UIImageView *bubbleImageView;
/** text label */
@property (strong , nonatomic) UILabel *label;

@end

@implementation ChatMessageTextCell

- (void)prepare
{
    [super prepare];
    
    // 气泡
    [self.messageContentView addSubview:self.bubbleImageView];
    // 文本
    [self.messageContentView addSubview:self.label];
#if DEBUG
    self.label.backgroundColor = [UIColor grayColor];
#endif
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;   // 多行
        _label.font = [ChatUI sharedUI].globalMessageTextFont;
        _label.textColor = [ChatUI sharedUI].globalMessageTextColor;
    }
    
    return _label;
}

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView)
    {
        _bubbleImageView = [[UIImageView alloc] init];
    }
    
    return _bubbleImageView;
}

- (void)layoutMessage
{
    [super layoutMessage];
    
    switch (self.messageModel.direction)
    {
        case ChatMessageDirection_send:
            self.bubbleImageView.image = [UIImage imageNamed:kMessageCell_BubbleImageSend];
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(5);
                make.left.mas_offset(5);
                make.bottom.mas_offset(-5);
                make.right.mas_offset(-12);
            }];
            break;
        case ChatMessageDirection_received:
            self.bubbleImageView.image = [UIImage imageNamed:kMessageCell_BubbleImageReceived];
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(5);
                make.left.mas_offset(12);
                make.bottom.mas_offset(-5);
                make.right.mas_offset(-5);
            }];
            break;
            
        default: break;
    }
    
    [self.bubbleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
}

- (void)setMessageModel:(ChatMessage *)messageModel
{
    [super setMessageModel:messageModel];
    
    ChatTextMessageContent *textContent = (ChatTextMessageContent *)messageModel.messageContent;
    self.label.text = textContent.text; // 设置文本消息
}


@end





