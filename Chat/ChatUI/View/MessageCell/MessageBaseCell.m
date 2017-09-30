//
//  MessageBaseCell.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "MessageBaseCell.h"

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
    NSLog(@"请重写[%@ %s]方法", NSStringFromClass(self.class), __FUNCTION__);
}

- (void)layoutMessage
{
    NSLog(@"请重写[%@ %s]方法", NSStringFromClass(self.class), __FUNCTION__);
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




