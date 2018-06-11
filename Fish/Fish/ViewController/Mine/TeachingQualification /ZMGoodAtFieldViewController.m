//
//  ZMGoodAtFieldViewController.m
//  Fish
//
//  Created by sunny on 2018/5/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGoodAtFieldViewController.h"
#import "ZMFieldModel.h"
#import "ZMFieldCollectionViewCell.h"

@interface ZMGoodAtFieldViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ZMGoodAtFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"擅长领域";
    [self configUI];
}

- (void)configUI {
    
    NSString *contan1 = [self.selectString containsString:@"增肌"] ? @"1" : @"0";
    NSString *contan2 = [self.selectString containsString:@"减脂"] ? @"1" : @"0";
    NSString *contan3 = [self.selectString containsString:@"塑形"] ? @"1" : @"0";
    NSString *contan4 = [self.selectString containsString:@"康复"] ? @"1" : @"0";
    NSString *contan5 = [self.selectString containsString:@"体态纠正"] ? @"1" : @"0";
    NSString *contan6 = [self.selectString containsString:@"拉伸放松"] ? @"1" : @"0";
    NSString *contan7 = [self.selectString containsString:@"搏击"] ? @"1" : @"0";
    NSString *contan8 = [self.selectString containsString:@"功能性训练"] ? @"1" : @"0";
    NSString *contan9 = [self.selectString containsString:@"竞技健美"] ? @"1" : @"0";

   
    ZMFieldModel *fieldModel = [[ZMFieldModel alloc] initWithTitle:@"增肌" imageName:@"image01" status:contan1];
    ZMFieldModel *fieldModel1 = [[ZMFieldModel alloc] initWithTitle:@"减脂" imageName:@"image02" status:contan2];
    ZMFieldModel *fieldModel2 = [[ZMFieldModel alloc] initWithTitle:@"塑形" imageName:@"image03" status:contan3];
    ZMFieldModel *fieldModel3 = [[ZMFieldModel alloc] initWithTitle:@"康复" imageName:@"image04" status:contan4];
    ZMFieldModel *fieldModel4 = [[ZMFieldModel alloc] initWithTitle:@"体态纠正" imageName:@"image05" status:contan5];
    ZMFieldModel *fieldModel5 = [[ZMFieldModel alloc] initWithTitle:@"拉伸放松" imageName:@"image06" status:contan6];
    ZMFieldModel *fieldModel6 = [[ZMFieldModel alloc] initWithTitle:@"搏击" imageName:@"image07" status:contan7];
     ZMFieldModel *fieldModel7 = [[ZMFieldModel alloc] initWithTitle:@"功能性训练" imageName:@"image08" status:contan8];
     ZMFieldModel *fieldModel8 = [[ZMFieldModel alloc] initWithTitle:@"竞技健美" imageName:@"image09" status:contan9];
    self.dataSource = @[fieldModel,fieldModel1,fieldModel2,fieldModel3,fieldModel4,fieldModel5,fieldModel6,fieldModel7,fieldModel8].mutableCopy;
    [self.view addSubview:self.collectionView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.block) {
        self.block(self.selectString);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMFieldCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMFieldCollectionViewCell" forIndexPath:indexPath];
    cell.fieldModel = self.dataSource[indexPath.item];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 50 - 10) / 2, 116);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(25, 20, 25, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"ZMFieldCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZMFieldCollectionViewCell"];
        
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMFieldModel *model = self.dataSource[indexPath.item];
    model.status = [model.status isEqualToString:@"0"] ? @"1" : @"0";
    NSMutableArray *array;
    if (self.selectString) {
    array = [self.selectString componentsSeparatedByString:@","].mutableCopy;
    } else {
        array = @[].mutableCopy;
    }
    
    if ([model.status isEqualToString:@"1"]) {
        [array addObject:model.title];
    } else {
        [array removeObject:model.title];
    }
    self.selectString = [array componentsJoinedByString:@","].mutableCopy;
    [self.collectionView reloadData];
}

@end
