//
//  ZBCyanCollectionReusableView.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBCyanCollectionReusableHeaderView.h"

@implementation ZBCyanCollectionReusableHeaderView

#pragma mark - ZBFancyCellProtocol
- (void)loadData:(id)data
{
    self.backgroundColor = [UIColor cyanColor];
}

+ (CGSize)itemSize:(id)data
{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 40);
}

+ (UIEdgeInsets)itemMargin:(id)data
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
