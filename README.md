```
# ZBFancyCollectionView

[![CI Status](https://img.shields.io/travis/373379320@qq.com/ZBFancyCollectionView.svg?style=flat)](https://travis-ci.org/373379320@qq.com/ZBFancyCollectionView)
[![Version](https://img.shields.io/cocoapods/v/ZBFancyCollectionView.svg?style=flat)](https://cocoapods.org/pods/ZBFancyCollectionView)
[![License](https://img.shields.io/cocoapods/l/ZBFancyCollectionView.svg?style=flat)](https://cocoapods.org/pods/ZBFancyCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/ZBFancyCollectionView.svg?style=flat)](https://cocoapods.org/pods/ZBFancyCollectionView)

## Example



#### 一丶基础用法


### Swift 

```
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black;
        
        self.collectionView.fancyLayout.hoverIndexPath = IndexPath(item: 0, section: 0)
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        // swiftlint:disable:next unused_result
        self.collectionView.zb_configCollectionView { config in
            _ = config.headerView("<cyanHeader>").cls("ZBFancyCollectionReusableView")
            _ = config.footerView("<greenFooter>").cls("ZBFancyCollectionReusableView");
            _ = config.cell("<title>").cls("ZBFancyCollectionViewCell");
            _ = config.cell("<red>").cls("ZBFancyCollectionViewCell");
            _ = config.cell("<yellow>").cls("ZBFancyCollectionViewCell");
            _ = config.cell("<blue>").cls("ZBFancyCollectionViewCell");
        }
        
        
        
        self.collectionView.zb_setup { maker in
            
            _ = maker.section("<1Section>")
            _ = maker.sectionHeader("<cyanHeader>").model([
                "height" : 44
            ] as [String : Any])
            _ = maker.sectionFooter("<greenFooter>")
            
            
            _ = maker.row("<red>")
                .model(["height": 44, "color": UIColor.red] as [String : Any]).initializeViewBlock{(cell: ZBFancyCollectionViewCell) in
                    
                    self._buildColorCell(cell)
                    
                }
            _ = maker.row("<yellow>")
                .model(["height": 44, "color": UIColor.yellow] as [String : Any]).initializeViewBlock{(cell: ZBFancyCollectionViewCell) in
                    
                    self._buildColorCell(cell)
                    
                }
            
            _ = maker.row("<blue>")
                .model(["height": 44, "color": UIColor.blue] as [String : Any]).initializeViewBlock{(cell: ZBFancyCollectionViewCell) in
                    self._buildColorCell(cell)
                }
        }
        
    }

```
### Objective-C

```oc
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [UICollectionView flowLayout];
    }
    return _collectionView;
}
{
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
```

#### 二丶不需要创建cell.h cell.m 写法

自带FancyCell模板

```oc
@interface ZBFancyTableViewCell : UITableViewCell

@property (nonatomic, strong) id cellRawData;
@property (nonatomic, strong) NSIndexPath *indexPath;

//初始化
@property (nonatomic, copy) void (^ initializeViewBlock)(ZBFancyTableViewCell *cell);
//重置view
@property (nonatomic, copy) void (^ resetViewBlock)(ZBFancyTableViewCell *cell);
//更新view
@property (nonatomic, copy) void (^ updateViewBlock)(ZBFancyTableViewCell *cell, id data);
//自定义布局
@property (nonatomic, copy) void (^ layoutSubviewsBlock)(ZBFancyTableViewCell *cell);

@end
```

> 使用

```oc
// 1. register
[self zb_configTableView:^(ZBCollectionProtoFactory *config) {
     config.cell(@"<empty>").cls(@"ZBFancyCollectionViewCell");
}];
        
// 2. config        
maker.row(@"<empty>").itemSize(CGSizeMake(kScreenWidth, 98)).initializeViewBlock(^(ZBFancyCollectionViewCell *cell) {
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 4;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor colorWithHexString:@"#B3B3B3"];
    label.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.bottom.offset(0);
    }];
    cell.updateViewBlock = ^(ZBFancyCollectionViewCell *cell, id data) {
        label.text = data;
    };
}).model(text);
```

#### 三丶悬停用法

使用ZBFancyLayout

```
@interface ZBFancyLayout : UICollectionViewLayout

@property (nonatomic, strong) ZBFancyLayoutHelper *layoutHelper;

@property (nonatomic, strong) NSMutableArray<ZBFancyLayoutItem *> *dataArray;

@property (nonatomic, assign) ZBFancyCollectionViewStyle style;
/**
 如果type = ZBFancyCollectionViewStyleCustom,需要指定hoverIndexPath,默认第一个
 */
@property (nonatomic, strong) NSIndexPath *hoverIndexPath;
/*
 悬浮偏移量
 */
@property (nonatomic, assign) CGFloat hoverOffset;

- (NSInteger)sectionCount;

@end
```

## Requirements

## Installation

ZBFancyCollectionView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZBFancyCollectionView'
```

## Author

373379320@qq.com, 373379320@qq.com

## License

ZBFancyCollectionView is available under the MIT license. See the LICENSE file for more info.

```

```
