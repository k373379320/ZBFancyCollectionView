//
//  ZBFancyBaseViewController.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/1.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBFancyBaseViewController.h"

@interface ZBFancyBaseViewController ()

@end

@implementation ZBFancyBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)makerConfig:(ZBCollectionProtoFactory *)config
{
    config.headerView(@"<cyanHeader>").cls(@"ZBCyanCollectionReusableHeaderView");
    config.footerView(@"<greenFooter>").cls(@"ZBGreenCollectionReusableFooterView");
    config.cell(@"<red>").cls(@"ZBRedCollectionViewCell");
    config.cell(@"<yellow>").cls(@"ZBYellowCollectionViewCell");
    config.cell(@"<blue>").cls(@"ZBBlueCollectionViewCell");
}
- (void)makerExample:(ZBCollectionMaker *)maker
{
    //tableView style
    maker.section(@"<1Section>");
    maker.sectionHeader(@"<cyanHeader>").model(@{});
    maker.sectionFooter(@"<greenFooter>").model(@{});
    
    maker.row(@"<red>").model(@{@"height": @(44),@"type": @(0)});
    maker.row(@"<yellow>").model(@{@"height": @(44),@"type": @(0)});
    maker.row(@"<blue>").model(@{@"height": @(44),@"type": @(0)});
    
    //collectionView Style
    maker.section(@"<2Section>");
    maker.sectionHeader(@"<cyanHeader>");
    maker.sectionFooter(@"<greenFooter>");
    
    for (NSInteger count = 0; count < 10; count ++ ) {
        maker.row(@"<red>").model(@{@"height": @(44),@"type": @(2)});
        maker.row(@"<yellow>").model(@{@"height": @(44),@"type": @(2)});
        maker.row(@"<blue>").model((@{@"height": @(44),@"type": @(2)}));
    }
    
    //flow Style
    maker.section(@"<3Section>");
    maker.sectionHeader(@"<cyanHeader>");
    maker.sectionFooter(@"<greenFooter>");
    
    for (NSInteger count = 0; count < 10; count ++ ) {
        maker.row(@"<red>").model(@{@"height": @(arc4random()%200 + 40),@"type": @(2)});
        maker.row(@"<yellow>").model(@{@"height": @(arc4random()%200 + 40),@"type": @(2)});
        maker.row(@"<blue>").model((@{@"height": @(arc4random()%200 + 40),@"type": @(2)}));        
    }
    
    //
    maker.section(@"<4Section>");
    maker.sectionHeader(@"<cyanHeader>");
    maker.sectionFooter(@"<greenFooter>");
    
    maker.row(@"<red>").model(@{@"height": @(40 + arc4random() %100),@"type": @(2)});
    maker.row(@"<yellow>").model(@{@"height": @(40 + arc4random() %100),@"type": @(2)});
    maker.row(@"<blue>").model((@{@"height": @(40 + arc4random() %100),@"type": @(1)}));
    maker.row(@"<red>").model(@{@"height": @(40 + arc4random() %100),@"type": @(2)});
    maker.row(@"<yellow>").model(@{@"height": @(40 + arc4random() %100),@"type": @(2)});
    maker.row(@"<blue>").model((@{@"height": @(40 + arc4random() %100),@"type": @(1)}));
}

@end
