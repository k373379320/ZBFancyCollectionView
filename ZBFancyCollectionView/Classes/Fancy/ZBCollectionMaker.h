//
//  ZBCollectionMaker.h
//  XZBProduct
//
//  Created by xzb on 2018/7/23.
//  Copyright © 2018年 xzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBSection.h"
#import "ZBFancyItem.h"
#import "ZBFancyCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface ZBCollectionViewSectionMaker : NSObject

@property (nonatomic, strong) ZBSection *section;

@end

@interface ZBCollectionRowMaker : NSObject

@property (nonatomic, strong) ZBFancyItem *row;

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^itemSize)(CGSize size);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^model)(id model);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^tag)(NSString *tag);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^configureSEL)(SEL selector);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^itemSizeSEL)(SEL selector);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^constructBlock)(UICollectionViewCell * (^)(id));

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^selectBlock)(void (^)(id));

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^configureBlock)(void (^)(id));

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^extraDictBlock)(NSDictionary *extraDict);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^bundle)(NSBundle *bundle);

@property (nonatomic, copy, readonly) ZBCollectionRowMaker * (^ initializeViewBlock)(void (^)(ZBFancyCollectionViewCell *cell));

@end

@interface ZBCollectionMaker : NSObject

@property (nonatomic, copy) ZBCollectionViewSectionMaker * (^section)(NSString *key);

@property (nonatomic, copy) ZBCollectionRowMaker * (^sectionHeader)(NSString *proto);

@property (nonatomic, copy) ZBCollectionRowMaker * (^sectionFooter)(NSString *proto);

@property (nonatomic, copy) ZBCollectionRowMaker * (^row)(NSString *proto);


/*是否允许移动

 Cell上还需要添加长按手势,才能拖动编辑
 
 Example:
 UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
 [cell addGestureRecognizer:longPress];
 
 - (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
 {
     CGPoint location = [gesture locationInView:self.collectionView];
     NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
     switch(gesture.state) {
         case UIGestureRecognizerStateBegan:
             [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
             break;
         case UIGestureRecognizerStateChanged:
             [self.collectionView updateInteractiveMovementTargetPosition:location];
             break;
         case UIGestureRecognizerStateEnded:
             [self.collectionView endInteractiveMovement];
             break;
         default:
             [self.collectionView cancelInteractiveMovement];
             break;
     }
 }
*/
@property (nonatomic, copy) ZBCollectionViewSectionMaker * (^canMove)(BOOL canMove);

- (NSArray *)install;

@end

NS_ASSUME_NONNULL_END
