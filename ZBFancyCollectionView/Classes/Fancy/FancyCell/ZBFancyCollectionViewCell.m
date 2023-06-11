//
//  ZBFancyCollectionViewCell.m
//  ZBFancyCollectionView
//
//  Created by 肖志斌 on 2020/2/12.
//

#import "ZBFancyCollectionViewCell.h"

@interface ZBFancyCollectionViewCell ()

@property (nonatomic, assign) BOOL initializedView;

@end

@implementation ZBFancyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initializeView
{
    if (self.initializedView) {
        return;
    }
    if (self.initializeViewBlock) {
        self.initializeViewBlock(self);
    }
    self.initializedView = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.layoutSubviewsBlock) {
        self.layoutSubviewsBlock(self);
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];

    if (self.resetViewBlock) {
        self.resetViewBlock(self);
    }
}

#pragma mark - IMXCellProtocol
+ (CGFloat)cellHeight:(id)model
{
    return 0;
}

+ (CGSize)itemSize:(id)data
{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 44);
}

+ (UIEdgeInsets)itemMargin:(id)data
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)loadData:(id)data
{
    [self initializeView];

    if (self.updateViewBlock) {
        self.updateViewBlock(self, data);
    }
}

@end
