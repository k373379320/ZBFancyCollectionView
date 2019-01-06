//
//  ZBGreenCollectionReusableFooterView.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBGreenCollectionReusableFooterView.h"

@implementation ZBGreenCollectionReusableFooterView

#pragma mark - ZBFancyCellProtocol
- (void)loadData:(id)data
{
    self.backgroundColor = [UIColor greenColor];
}

+ (CGSize)itemSize:(id)data
{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 20);
}

+ (UIEdgeInsets)itemMargin:(id)data
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
