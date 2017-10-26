//
//  ChatEmojiBoardView.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatEmojiBoardView.h"
#import "ChatEmojiIItem.h"
#import <Masonry.h>

const CGFloat kChatEmojiKeyboardHeight = 200.0f;
const NSInteger kChatEmojiNumberOfCols = 10;

static NSString * const kCellIdef = @"Cell";

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24)

@interface ChatEmojiBoardView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic) UICollectionView *emojiCollectionView;
@property (strong , nonatomic) NSArray <EmojiItem *>*emojis;

@end

@implementation ChatEmojiBoardView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepareUI];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self prepareUI];
    }
    
    return self;
}

- (instancetype)initWithTextView:(UITextView *)textView
{
    if (self = [super initWithTextView:textView])
    {
        [self prepareUI];
    }
    
    return self;
}

- (instancetype)initWithTextField:(UITextField *)textField
{
    if (self = [super initWithTextField:textField])
    {
        [self prepareUI];
    }
    
    return self;
}

- (void)prepareUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.emojiCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.emojiCollectionView.dataSource = self;
    self.emojiCollectionView.delegate = self;
    self.emojiCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.emojiCollectionView];
    [self.emojiCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.emojiCollectionView registerClass:[ChatEmojiIItem class] forCellWithReuseIdentifier:kCellIdef];
    
    // 获取emoji
    [self.class getSystemEmojis:^(NSArray *emojis) {
        NSMutableArray *mEmojis = [[NSMutableArray alloc] init];
        for (NSString *eString in emojis)
        {
            EmojiItem *item = [EmojiItem emojiWithEncode:eString type:EmojiItemType_emoji];
            [mEmojis addObject:item];
        }
        
        self.emojis = [mEmojis copy];
        [self.emojiCollectionView reloadData];
    }];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojis.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ChatEmojiIItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdef forIndexPath:indexPath];
    
    EmojiItem *itemModel = [self.emojis objectAtIndex:indexPath.row];
    item.label.text = itemModel.emojiEncode;
    
    return item;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmojiItem *item = [self.emojis objectAtIndex:indexPath.row];
    
    if (self.textView)
    {
        [self.textView insertText:item.emojiEncode];
    }
    
    if (self.textField)
    {
        [self.textField insertText:item.emojiEncode];
    }
    
    if ([self.delegate respondsToSelector:@selector(emojiBoardView:clickEmoji:)])
    {
        [self.delegate emojiBoardView:self clickEmoji:item];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemSize = (self.bounds.size.width - 10) / (CGFloat)kChatEmojiNumberOfCols;
    return CGSizeMake(itemSize, itemSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);    //分别为上、左、下、右
}

#pragma mark - emoji

/**
 获取系统emoji
 
 @param callback 获取完成的回调
 */
+ (void)getSystemEmojis:(void(^)(NSArray *emojis))callback
{
    // EMOJI_CODE_TO_SYMBOL 是宏定义的转换函数
    NSMutableArray *returnAr = [NSMutableArray new];
    // 使用同步操作，把所有的值获取后再返还数组。
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (int i=0x1F600; i<=0x1F64F; i++)
        {
            if (i < 0x1F641 || i > 0x1F644)
            {
                int number = EMOJI_CODE_TO_SYMBOL(i);
                NSString *epressionStr = [[NSString alloc] initWithBytes:&number length:sizeof(number) encoding:NSUTF8StringEncoding];
                [returnAr addObject:epressionStr];
            }
        }
    });
    
    if (callback)
    {
        callback(returnAr);
    }
}



@end






