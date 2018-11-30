//
//  ChatEmojiIItem.m
//  Chat
//
//  Created by 李立 on 2017/10/24.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatEmojiItemCell.h"
#import <Masonry.h>

@implementation ChatEmojiItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self prepareUI];
    }
    
    return self;
}

- (void)prepareUI
{
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:30];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.userInteractionEnabled = YES;
    }
    
    return _label;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _imageView;
}

@end





