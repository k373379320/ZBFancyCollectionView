//
//  ZBDataSource.h
//  XZBProduct
//
//  Created by xzb on 2018/7/23.
//  Copyright © 2018年 xzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBFancyCollectionData.h"

@interface ZBCollectionViewDataSource : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) ZBFancyCollectionData *collectionData;

@property (nonatomic, weak) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, copy) void (^ cellForRowHandler)(UICollectionView *collection, NSIndexPath *indexPath);

@property (nonatomic, copy) void (^ willDisplayCellHander)(UICollectionView *cell, NSIndexPath *indexPath);

- (instancetype)initWithCollectionView:(UICollectionView *)tableView;

- (void)registerCell:(Class)cellClass identifier:(NSString *)identifier;

- (void)registerNib:(UINib *)nib cellClass:(Class)cellClass identifier:(NSString *)identifier;

- (void)registerHeaderView:(Class)viewClass identifier:(NSString *)identifier;

- (void)registerFooterView:(Class)viewClass identifier:(NSString *)identifier;

- (void)registerHeaderNib:(UINib *)nib viewClass:(Class)viewClass identifier:(NSString *)identifier;

- (void)registerFooterNib:(UINib *)nib viewClass:(Class)viewClass identifier:(NSString *)identifier;

- (void)updateAll:(NSArray<__kindof ZBSection *> *)sections;

@end
