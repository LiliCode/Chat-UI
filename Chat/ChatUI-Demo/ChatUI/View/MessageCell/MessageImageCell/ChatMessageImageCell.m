//
//  MessageImageCell.m
//  Chat
//
//  Created by 李立 on 2017/10/31.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatMessageImageCell.h"
#import <Photos/Photos.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import <Masonry/Masonry.h>

@interface ChatMessageImageCell ()
@property (strong , nonatomic) UIImageView *photoImageView;

@end

@implementation ChatMessageImageCell

- (void)prepare
{
    [super prepare];
    
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill; // 平铺展示
    self.photoImageView.clipsToBounds = YES;    // 剪切超出区域的显示
    [self.messageContentView addSubview:self.photoImageView];
}

- (void)layoutMessage
{
    [super layoutMessage];
    
    switch (self.messageModel.direction)
    {
        case ChatMessageDirection_send:
            [self.photoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(3, 3, 3, 10));
            }];
            break;
        case ChatMessageDirection_received:
            [self.photoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(3, 10, 3, 3));
            }];
            break;
            
        default: break;
    }
}

- (void)setMessageModel:(ChatMessage *)messageModel
{
    [super setMessageModel:messageModel];
    
    ChatImageMessageContent *content = (ChatImageMessageContent *)messageModel.messageContent;
    
    if ([content.image isMemberOfClass:[UIImage class]])    // UIImage 对象
    {
        self.photoImageView.image = content.image;
    }
    else if ([content.image isKindOfClass:[NSString class]])// NSString对象，一般是图片链接
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
    else if ([content.image isMemberOfClass:[PHAsset class]]) // Photos
    {
        PHAsset *asset = (PHAsset *)content.image;
        // 展示缩略图
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:[ChatUI sharedUI].globalMessageImageSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            self.photoImageView.image = result;
        }];
    }
}

@end



