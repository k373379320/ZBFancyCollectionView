//
//  ZBFancyCollectionViewCell.h
//  ZBFancyCollectionView
//
//  Created by 肖志斌 on 2020/2/12.
//

#import <UIKit/UIKit.h>


@interface ZBFancyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id cellRawData;
@property (nonatomic, strong) NSIndexPath *indexPath;

//初始化
@property (nonatomic, copy) void (^ initializeViewBlock)(ZBFancyCollectionViewCell *cell);
//重置view
@property (nonatomic, copy) void (^ resetViewBlock)(ZBFancyCollectionViewCell *cell);
//更新view
@property (nonatomic, copy) void (^ updateViewBlock)(ZBFancyCollectionViewCell *cell, id data);
//自定义布局
@property (nonatomic, copy) void (^ layoutSubviewsBlock)(ZBFancyCollectionViewCell *cell);

+ (CGFloat)cellHeight:(id)model;
+ (CGSize)itemSize:(id)data;
+ (UIEdgeInsets)itemMargin:(id)data;

- (void)loadData:(id)data;

@end
