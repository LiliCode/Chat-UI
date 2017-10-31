//
//  MessageBaseCell.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "MessageBaseCell.h"
#import <Masonry.h>



@interface MessageBaseCell ()
/** 头像 - logo*/
@property (strong , nonatomic) UIImageView *pLogoImageView;
/** 展示内容 - content view*/
@property (strong , nonatomic) UIView *pMessageContentView;

@end

@implementation MessageBaseCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutMessage];
}

#pragma mark - UI

- (void)prepare
{
#pragma mark - cell的风格设置
    self.selectionStyle = UITableViewCellSelectionStyleNone;
#pragma mark - 添加消息Cell最基本的视图
    // 头像
    self.pLogoImageView = [[UIImageView alloc] init];
    self.pLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.pLogoImageView];
    // msg content view
    self.pMessageContentView = [[UIView alloc] init];
    [self addSubview:self.pMessageContentView];
    
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
        case MessageDirection_send: // 发出的消息
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
        case MessageDirection_received: // 接收到的消息
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










@end




