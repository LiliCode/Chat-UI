//
//  MessageBaseCell.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageBaseCell.h"
#import <Masonry.h>



@interface ChatMessageBaseCell ()
/** 头像 - logo*/
@property (strong , nonatomic) UIImageView *pLogoImageView;
/** 展示内容 - content view*/
@property (strong , nonatomic) UIView *pMessageContentView;

@end

@implementation ChatMessageBaseCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 初始化操作
    [self prepare];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 初始化操作
        [self prepare];
    }
    
    return self;
}

- (UIImageView *)pLogoImageView
{
    if (!_pLogoImageView)
    {
        _pLogoImageView = [[UIImageView alloc] init];
        _pLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _pLogoImageView;
}

- (UIView *)pMessageContentView
{
    if (!_pMessageContentView)
    {
        _pMessageContentView = [[UIView alloc] init];
    }
    
    return _pMessageContentView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // layout
    [self layoutMessage];
}

#pragma mark - UI

- (void)prepare
{
#pragma mark - 风格设置
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = self.superview.backgroundColor;
#pragma mark - 添加消息Cell最基本的视图
    // 头像
    [self.contentView addSubview:self.pLogoImageView];
    // msg content view
    [self.contentView addSubview:self.pMessageContentView];
    
    // ...
    // 其他的视图请在派生类中添加
#if DEBUG
    self.pLogoImageView.backgroundColor = [UIColor redColor];
    self.pMessageContentView.backgroundColor = [UIColor greenColor];
#endif
}

- (void)layoutMessage
{
    __weak typeof (self) weakSelf = self;
    switch (self.messageModel.direction)
    {
        case ChatMessageDirection_send: // 发出的消息
        {
            // 布局头像
            [self.pLogoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(10);
                make.right.mas_offset(-10);
                make.size.mas_offset([ChatUI sharedUI].globalMessagePortraitSize);
            }];
            // 布局 content view
            [self.pMessageContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(10);
                make.right.equalTo(weakSelf.pLogoImageView.mas_left).offset(-10);
                make.bottom.mas_offset(-10);
                make.width.mas_offset([ChatUI sharedUI].globalMessageContentViewMaxWidth);
            }];
        } break;
        case ChatMessageDirection_received: // 接收到的消息
        {
            // 布局头像
            [self.pLogoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(10);
                make.left.mas_offset(10);
                make.size.mas_offset([ChatUI sharedUI].globalMessagePortraitSize);
            }];
            // 布局 content view
            [self.pMessageContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(10);
                make.left.equalTo(weakSelf.pLogoImageView.mas_right).offset(10);
                make.bottom.mas_offset(-10);
                make.width.mas_offset([ChatUI sharedUI].globalMessageContentViewMaxWidth);
            }];
        } break;
            
        default: break;
    }
    
    // text label size
    ChatMessageContent *content = self.messageModel.messageContent;
    [self.messageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(content.contentSize.width);
    }];
    
    [self.messageContentView layoutIfNeeded];
}


#pragma mark - getter setter

- (UIImageView *)logoImageView
{
    return self.pLogoImageView;
}

- (UIView *)messageContentView
{
    return self.pMessageContentView;
}

- (void)setMessageModel:(ChatMessage *)messageModel
{
    _messageModel = messageModel;
    // 设置头像
    self.logoImageView.image = [UIImage imageNamed:messageModel.senderUserInfo.userLogo];
}


// 高度
- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, self.messageModel.messageContent.contentSize.height);
}




@end




