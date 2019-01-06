//
//  ZBBlueCollectionViewCell.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBBlueCollectionViewCell.h"

@implementation ZBBlueCollectionViewCell

#pragma mark - ZBFancyCellProtocol
- (void)loadData:(id)data
{
    self.contentView.backgroundColor = [UIColor blueColor];
}

+ (CGSize)itemSize:(id)data
{
    NSDictionary *dict = data;
    NSInteger type = [dict[@"type"] integerValue];
    CGFloat height = [data[@"height"] floatValue];
    if (type == 0) {
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height);
    } else if (type == 1) {
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) /2, height);
    } else if (type == 2) {
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) /4, height);
    }
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height);
}

+ (UIEdgeInsets)itemMargin:(id)data
{
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

@end
