//
//  ZBDataSource.m
//  XZBProduct
//
//  Created by xzb on 2018/7/23.
//  Copyright © 2018年 xzb. All rights reserved.
//

#import "ZBCollectionViewDataSource.h"
#import "ZBFancyItem.h"
#import "ZBSection.h"
#import <objc/message.h>
#import "ZBFancyCollectionViewCell.h"

static NSString *const ZBCollectionViewFancyProtoTypeIdentifierKey = @"identifier";
static NSString *const ZBCollectionViewFancyProtoTypeClassKey = @"class";
static NSString *const ZBCollectionViewFancyProtoTypeNibKey = @"nib";

@interface ZBCollectionViewDataSource ()

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *protoTypes;
@property (nonatomic, strong, readwrite) ZBFancyCollectionData *collectionData;

@end

@implementation ZBCollectionViewDataSource

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _protoTypes = [NSMutableDictionary dictionary];
        _collectionData = [[ZBFancyCollectionData alloc] init];
    }
    return self;
}

- (void)registerHeaderView:(Class)viewClass identifier:(NSString *)identifier
{
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : viewClass};
    
    [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registerFooterView:(Class)viewClass identifier:(NSString *)identifier
{
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : viewClass};
    
    [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

- (void)registerHeaderNib:(UINib *)nib viewClass:(Class)viewClass identifier:(NSString *)identifier
{
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : viewClass};
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registerFooterNib:(UINib *)nib viewClass:(Class)viewClass identifier:(NSString *)identifier
{
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : viewClass};
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

- (void)registerCell:(Class)cellClass identifier:(NSString *)identifier
{
    NSAssert(identifier && [identifier length] > 0, @"identifer must not be empty");
    NSAssert(!(self.protoTypes[identifier]), @"%@ was already registerred", identifier);
    NSAssert(cellClass != nil, @"cellClass must not be nil");
    
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : cellClass};
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib cellClass:(Class)cellClass identifier:(NSString *)identifier
{
    NSAssert(identifier && [identifier length] > 0, @"identifer must not be empty");
    NSAssert(!(self.protoTypes[identifier]), @"%@ was already registerred", identifier);
    NSAssert(cellClass != nil, @"cellClass must not be nil");
    NSAssert(nib, @"nib must not be nill");
    
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : cellClass,
                                ZBCollectionViewFancyProtoTypeNibKey : nib};
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib headerFooterViewClass:(Class)viewClass identifier:(NSString *)identifier
{
    _protoTypes[identifier] = @{ZBCollectionViewFancyProtoTypeClassKey : viewClass,
                                ZBCollectionViewFancyProtoTypeNibKey : nib};
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)updateAll:(NSArray<__kindof ZBSection *> *)sections
{
    [self.collectionData resetWithSections:sections];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.collectionData.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionData sectionAtIdx:section].rows.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.willDisplayCellHander) {
        self.willDisplayCellHander(cell,indexPath);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSection *section = [self.collectionData sectionAtIdx:indexPath.section];
    ZBFancyItem *row = [section rowAtIdx:indexPath.row];
    
    if (row) {
        if (self.cellForRowHandler) {
            self.cellForRowHandler(collectionView, indexPath);
        }
        
        if (row.constructBlock) {
            return row.constructBlock(row.rawModel);
        }
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.protoType forIndexPath:indexPath];
        
        if ([cell isKindOfClass:[ZBFancyCollectionViewCell class]]) {
            ZBFancyCollectionViewCell *fancyCell = (ZBFancyCollectionViewCell *)cell;
            fancyCell.initializeViewBlock = row.initializeViewBlock;
            fancyCell.indexPath = indexPath;
            fancyCell.cellRawData = row.rawModel;
        }
        
        if (row.configSel) {
            if ([cell respondsToSelector:row.configSel]) {
                ((void (*)(id, SEL, id)) objc_msgSend)(cell, row.configSel, row.rawModel);
            }
        }
        
        if (row.configureBlock) {
            row.configureBlock(row.rawModel);
        }
        
        return cell;
    } else {
        return [[UICollectionViewCell alloc] init];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZBSection *sec = [self.collectionData sectionAtIdx:indexPath.section];
    if (!sec) {
        sec = [self.collectionData.sections firstObject];
    }
    if (sec && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZBFancyItem *row = sec.headerView;
        if (row) {
            if (row.constructBlock) {
                return row.constructBlock(row.rawModel);
            }
        }
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:row.protoType forIndexPath:indexPath];
        if ([reusableView respondsToSelector:row.configSel]) {
            ((void (*)(id, SEL, id)) objc_msgSend)(reusableView, row.configSel, row.rawModel);
        }
        return reusableView;
    }
    if (sec && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ZBFancyItem *row = sec.footerView;
        if (row) {
            if (row.constructBlock) {
                return row.constructBlock(row.rawModel);
            }
        }
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:row.protoType forIndexPath:indexPath];
        if ([reusableView respondsToSelector:row.configSel]) {
            ((void (*)(id, SEL, id)) objc_msgSend)(reusableView, row.configSel, row.rawModel);
        }
        return reusableView;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    //当前支持section编辑区域,如果要支持cell去判定支持,需要再度开发
    ZBSection *section = [self.collectionData sectionAtIdx:indexPath.section];
    if (section.canMove) {
        return  YES;
    }
    return  NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    ZBSection *section = [self.collectionData sectionAtIdx:sourceIndexPath.section];
    ZBFancyItem *row = [section rowAtIdx:sourceIndexPath.item];
    [section moveItemInInnerRowsFromIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

/* 以下是实现右边标题功能,以及点击触发具体事件
 //显示右边标题
 - (nullable NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView
 {
 return @[@"1",@"2",@"3",@"4",];
 }
 
 //右边标题点击响应
 - (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index
 {
 return  [NSIndexPath indexPathForItem:0 inSection:0];
 }
 */

// indexPaths are ordered ascending by geometric distance from the collection view
- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    
    NSLog(@"prefetchItemsAtIndexPaths");
}

- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSLog(@"cancelPrefetchingForItemsAtIndexPaths");
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSection *section = [self.collectionData sectionAtIdx:indexPath.section];
    ZBFancyItem *row = [section rowAtIdx:indexPath.row];
    if (row.selectHandler) {
        row.selectHandler(row.rawModel);
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSection *section = [self.collectionData sectionAtIdx:indexPath.section];
    ZBFancyItem *row = [section rowAtIdx:indexPath.row];
    
    if (row.itemSize.height > 0 || row.itemSize.width > 0) {
        return row.itemSize;
    }
    if (row.itemSizeSel) {
        Class cls = (_protoTypes[row.protoType] ? _protoTypes[row.protoType][ZBCollectionViewFancyProtoTypeClassKey] : nil);
        if (cls) {
            id model = row.rawModel;
            if ([cls respondsToSelector:row.itemSizeSel]) {
                return ZBGetSizeSendMsg(cls, row.itemSizeSel, model);
            }
        }
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    ZBSection *sec = [self.collectionData sectionAtIdx:section];
    ZBFancyItem *row = sec.headerView;
    if (row) {
        if (row.itemSize.height > 0 || row.itemSize.width > 0) {
            if ([self needFixEmptyHeaderLayoutWithCollectionViewLayout:collectionViewLayout row:row]) {
                return CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
            }
            return row.itemSize;;
        }
        if (row.itemSizeSel) {
            Class cls = (_protoTypes[row.protoType] ? _protoTypes[row.protoType][ZBCollectionViewFancyProtoTypeClassKey] : nil);
            if (cls) {
                id model = row.rawModel;
                if ([cls respondsToSelector:row.itemSizeSel]) {
                    return ZBGetSizeSendMsg(cls, row.itemSizeSel, model);
                }
            }
        }
    }
    return CGSizeZero;
}

//这是特殊的占位header,需要特殊处理
- (BOOL)needFixEmptyHeaderLayoutWithCollectionViewLayout:(UICollectionViewLayout *)collectionViewLayout row:(ZBFancyItem *)row
{
    if ([row.protoType isEqualToString:@"<__empty_header__>"]) {
        return YES;
    }
    return  NO;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    ZBSection *sec = [self.collectionData sectionAtIdx:section];
    ZBFancyItem *row = sec.footerView;
    if (row) {
        if (row.itemSize.height > 0 || row.itemSize.width > 0) {
            return row.itemSize;
        }
        if (row.itemSizeSel) {
            Class cls = (_protoTypes[row.protoType] ? _protoTypes[row.protoType][ZBCollectionViewFancyProtoTypeClassKey] : nil);
            if (cls) {
                id model = row.rawModel;
                if ([cls respondsToSelector:row.itemSizeSel]) {
                    return ZBGetSizeSendMsg(cls, row.itemSizeSel, model);
                }
            }
        }
    }
    return CGSizeZero;
}
//item间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

/* 一些可有可无的操作
 
 // 能否选中
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 
 // 选中后能否弹出菜单
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 
 // 能否执行菜单里的某个操作
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return YES;
 }
 
 // 棘突执行菜单选项的操作
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
 
 
 }
 }
 */


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.scrollDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.scrollDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.scrollDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}
@end
