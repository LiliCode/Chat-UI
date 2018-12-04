//
//  ChatMessageBubbleCell.m
//  Chat
//
//  Created by 李立 on 2017/11/11.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageBubbleCell.h"
#import <Masonry/Masonry.h>
#import "UIImage+ChatUI.h"

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
        case ChatMessageDirection_send: {
            UIImage *bubbleImage = [UIImage chat_imageNamed:kMessageCell_BubbleImageSend];
            self.bubbleImageView.image = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 12, 32)];
        } break;
        case ChatMessageDirection_received: {
            UIImage *bubbleImage = [UIImage chat_imageNamed:kMessageCell_BubbleImageReceived];
            self.bubbleImageView.image = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 12, 50)];
        } break;
            
        default: break;
    }
    
    [self.bubbleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.and.right.mas_offset(0);
    }];
}


@end






