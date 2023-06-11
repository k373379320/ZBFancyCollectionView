//
//  ZBFancyCollectionReusableView.m
//  ZBFancyCollectionView
//
//  Created by 肖志斌 on 2023/6/11.
//

#import "ZBFancyCollectionReusableView.h"
#import "NSDictionary+ZBFancySafeValue.h"

@implementation ZBFancyCollectionReusableView

#pragma mark - ZBFancyCellProtocol
- (void)loadData:(id)data
{
    self.backgroundColor = [UIColor orangeColor];
}

+ (CGSize)itemSize:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]){
        CGFloat height = [data zb_safeFloatValueForKey:@"height" defaultValue:CGFLOAT_MIN];
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height);        
    }
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGFLOAT_MIN);
}

+ (UIEdgeInsets)itemMargin:(id)data
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
