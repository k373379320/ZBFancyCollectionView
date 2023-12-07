//
//  ZBSection.h
//  XZBProduct
//
//  Created by xzb on 2018/7/23.
//  Copyright © 2018年 xzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZBFancyItem;

@interface ZBSection : NSObject

@property (nonatomic, copy) NSString *key;

@property (nonatomic, strong) ZBFancyItem *headerView;

@property (nonatomic, strong) ZBFancyItem *footerView;

//是否支持移动
@property (nonatomic, assign) BOOL canMove;


- (NSArray<__kindof ZBFancyItem *> *)rows;

- (ZBFancyItem *)rowAtIdx:(NSInteger)idx;

- (void)appendRows:(NSArray<__kindof ZBFancyItem *> *)rows;

- (void)insertRows:(NSArray<__kindof ZBFancyItem *> *)rows atIdx:(NSUInteger)idx;

- (void)deleteRowsForIdxs:(NSArray<NSNumber *> *)idxs;

- (void)moveRowFromIdx:(NSUInteger)fromIdx toIndex:(NSUInteger)toIdx;

- (void)replaceSectionWithRows:(NSArray<__kindof ZBFancyItem *> *)rows;

- (void)moveItemInInnerRowsFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end
