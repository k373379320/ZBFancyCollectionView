//
//  ZBCustomLayoutViewController.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBCustomLayoutViewController.h"

@interface ZBCustomLayoutViewController ()

@end

@implementation ZBCustomLayoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionHeadersPinToVisibleBounds = YES;
    self.collectionView = [UICollectionView collectionViewWithLayout:layout];
    
    self.view.backgroundColor = self.collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        } else {
            make.top.bottom.offset(0);
        }
        make.left.right.offset(0);
    }];
    __weak typeof(self) weakSelf = self;
    
    //register
    [self.collectionView zb_configTableView:^(ZBCollectionProtoFactory *config) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf makerConfig:config];
    }];
    //data
    [self.collectionView zb_setup:^(ZBCollectionMaker *maker) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf makerExample:maker];
    }];
}


@end
