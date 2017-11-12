//
//  ChatMessageBubbleCell.m
//  Chat
//
//  Created by 李立 on 2017/11/11.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageBubbleCell.h"
#import <Masonry.h>

@interface ChatMessageBubbleCell ()
/** 气泡图片 */
@property (strong , nonatomic) UIImageView *bubbleImageView;

@end

@implementation ChatMessageBubbleCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

- (void)prepare
{
    [super prepare];
    
    // 气泡
    [self.messageContentView addSubview:self.bubbleImageView];
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
            break;
        case ChatMessageDirection_received:
            self.bubbleImageView.image = [UIImage imageNamed:kMessageCell_BubbleImageReceived];
            break;
            
        default: break;
    }
    
    [self.bubbleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.and.right.mas_offset(0);
    }];
}


@end






