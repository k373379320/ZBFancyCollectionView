//
//  ZBRedCollectionViewCell.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBRedCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation ZBRedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLable];

        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
    }
    return self;
}

#pragma mark - ZBFancyCellProtocol
- (void)loadData:(id)data
{
    self.contentView.backgroundColor = [UIColor redColor];
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
- (UILabel *)titleLable
{
    if (!_titleLable){
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont systemFontOfSize:36];
        _titleLable.textColor = [UIColor whiteColor];
    }
    return _titleLable;
}

@end
