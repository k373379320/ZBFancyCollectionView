//
//  ZBFancyBaseViewController.h
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ZBFancyCollectionView/UICollectionView+ZBFancy.h>
#import <Masonry/Masonry.h>

@interface ZBFancyBaseViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)makerConfig:(ZBCollectionProtoFactory *)config;

- (void)makerExample:(ZBCollectionMaker *)maker;

@end
