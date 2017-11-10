//
//  MessageImageCell.m
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageImageCell.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <Masonry.h>

@interface ChatMessageImageCell ()
@property (strong , nonatomic) UIImageView *photoImageView;

@end

@implementation ChatMessageImageCell

- (void)prepare
{
    [super prepare];
    
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.messageContentView addSubview:self.photoImageView];
}

- (void)layoutMessage
{
    [super layoutMessage];
    
    [self.photoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
}

- (void)setMessageModel:(ChatMessage *)messageModel
{
    [super setMessageModel:messageModel];
    
    ChatImageMessageContent *content = (ChatImageMessageContent *)messageModel.messageContent;
    
    if ([content.image isMemberOfClass:[UIImage class]])
    {
        self.photoImageView.image = content.image;
    }
    else if ([content.image isKindOfClass:[NSString class]])
    {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:content.image];
        if (image)
        {
            self.photoImageView.image = image;
        }
        else
        {
            [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:content.image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image)
                {
                    [[SDImageCache sharedImageCache] storeImage:image forKey:content.image completion:nil];
                }
            }];
        }
    }
}

@end



