//
//  ZBFancyCollectionViewTableViewController.m
//  ZBFancyCollectionView_Example
//
//  Created by xzb on 2018/8/2.
//  Copyright © 2018年 373379320@qq.com. All rights reserved.
//

#import "ZBFancyCollectionViewTableViewController.h"
#import "ZBFancyLayoutViewController.h"

@interface ZBFancyCollectionViewTableViewController ()

@end

@implementation ZBFancyCollectionViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![sender isKindOfClass:[UITableViewCell class]]) {
        return;
    }
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if ([segue.destinationViewController isKindOfClass:[ZBFancyLayoutViewController class]]) {
        ZBFancyLayoutViewController *vc = (ZBFancyLayoutViewController *)segue.destinationViewController;
        if (indexPath.row == 0) {
            vc.style = ZBFancyCollectionViewStyleGrouped;
        } else if (indexPath.row == 1) {
            vc.style = ZBFancyCollectionViewStylePlain;
        } else if (indexPath.row == 2) {
            vc.style = ZBFancyCollectionViewStyleCustom;
        }
    }
}

@end
