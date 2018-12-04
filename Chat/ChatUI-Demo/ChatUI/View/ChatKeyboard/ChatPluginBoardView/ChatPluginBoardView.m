//
//  ChatPluginBoardView.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ChatPluginBoardView.h"
#import "ChatPluginItemCell.h"
#import "UIImage+ChatUI.h"
#import <Masonry/Masonry.h>

NSString * const kChatPluginKeyboardWillShowNotification = @"kChatPluginKeyboardWillShowNotification";
NSString * const kChatPluginKeyboardWillHideNotification = @"kChatPluginKeyboardWillHideNotification";
NSString * const kChatPluginKeyboardDidShowNotification = @"kChatPluginKeyboardDidShowNotification";
NSString * const kChatPluginKeyboardDidHideNotification = @"kChatPluginKeyboardDidHideNotification";

const CGFloat kChatPluginKeyboardHeight = 200.0f;
const CGFloat kChatPluginKeyboardAnimationDuration = 0.25f;


static NSString * const kCellIdef = @"Cell";
const NSInteger kChatPluginNumberOfCols = 5;

@interface ChatPluginBoardView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** plugin list */
@property (strong , nonatomic) NSMutableArray *pluginList;
/** 集合视图 */
@property (strong , nonatomic) UICollectionView *collectionView;

@end

@implementation ChatPluginBoardView

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

- (void)prepareUI
{
    self.backgroundColor = rgbColor(244.0f, 244.0f, 246.0f, 1);
    
    // collection
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    // 注册cell
    [self.collectionView registerClass:[ChatPluginItemCell class] forCellWithReuseIdentifier:kCellIdef];
}

- (NSMutableArray *)pluginList
{
    if (!_pluginList)
    {
        _pluginList = [[NSMutableArray alloc] init];
    }
    
    return _pluginList;
}


- (void)insertPluginItem:(ChatPluginItem *)item
{
    [self.pluginList addObject:item];
    if (self.pluginList.count == 1 || [self.collectionView numberOfItemsInSection:0] == self.pluginList.count)
    {
        [self.collectionView reloadData];
    }
    else
    {
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.pluginList.count inSection:0]]];
    }
}

- (void)reloadPlugins
{
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pluginList.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ChatPluginItemCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdef forIndexPath:indexPath];
    
    ChatPluginItem *itemModel = [self.pluginList objectAtIndex:indexPath.row];
    item.label.text = itemModel.title;
    item.imageView.image = [UIImage chat_imageNamed:itemModel.image];
    
    return item;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChatPluginItem *item = [self.pluginList objectAtIndex:indexPath.row];
    
    if (item.callback)
    {
        item.callback(item);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemSize = (self.bounds.size.width - (kChatPluginNumberOfCols + 1) * 10) / (CGFloat)kChatPluginNumberOfCols;
    return CGSizeMake(itemSize, itemSize + 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);    //分别为上、左、下、右
}

@end







