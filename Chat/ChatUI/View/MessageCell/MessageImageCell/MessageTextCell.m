//
//  MessageTextCell.m
//  Chat
//
//  Created by 李立 on 2017/10/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "MessageTextCell.h"
#import <Masonry.h>

@interface MessageTextCell ()
/** 气泡图片 */
@property (strong , nonatomic) UIImageView *bubbleImageView;
/** text label */
@property (strong , nonatomic) UILabel *label;

@end

@implementation MessageTextCell

- (void)prepare
{
    [super prepare];
    
    // 气泡
    self.bubbleImageView = [[UIImageView alloc] init];
    [self.messageContentView addSubview:self.bubbleImageView];
    // 文本
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;   // 多行
    self.label.font = [ChatUI sharedUI].globalMessageTextFont;
    self.label.textColor = [ChatUI sharedUI].globalMessageTextColor;
    self.label.backgroundColor = [UIColor grayColor];
    [self.messageContentView addSubview:self.label];
}

- (void)layoutMessage
{
    [super layoutMessage];
    
    switch (self.messageModel.direction)
    {
        case MessageDirection_send:
            self.bubbleImageView.image = [UIImage imageNamed:kMessageCell_BubbleImageSend];
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(8);
                make.left.mas_offset(8);
                make.bottom.mas_offset(-8);
                make.right.mas_offset(-16);
            }];
            break;
        case MessageDirection_received:
            self.bubbleImageView.image = [UIImage imageNamed:kMessageCell_BubbleImageReceived];
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(8);
                make.left.mas_offset(16);
                make.bottom.mas_offset(-8);
                make.right.mas_offset(-8);
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







@end






