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
    ZMFieldModel *fieldModel = [[ZMFieldModel alloc] initWithTitle:@"增肌" imageName:@"image01" status:@"1"];
    ZMFieldModel *fieldModel1 = [[ZMFieldModel alloc] initWithTitle:@"减脂" imageName:@"image02" status:@"1"];
    ZMFieldModel *fieldModel2 = [[ZMFieldModel alloc] initWithTitle:@"塑形" imageName:@"image03" status:@"1"];
    ZMFieldModel *fieldModel3 = [[ZMFieldModel alloc] initWithTitle:@"康复" imageName:@"image04" status:@"1"];
    ZMFieldModel *fieldModel4 = [[ZMFieldModel alloc] initWithTitle:@"体态纠正" imageName:@"image05" status:@"0"];
    ZMFieldModel *fieldModel5 = [[ZMFieldModel alloc] initWithTitle:@"拉伸放松" imageName:@"image06" status:@"0"];
    ZMFieldModel *fieldModel6 = [[ZMFieldModel alloc] initWithTitle:@"搏击" imageName:@"image07" status:@"0"];
     ZMFieldModel *fieldModel7 = [[ZMFieldModel alloc] initWithTitle:@"功能性训练" imageName:@"image08" status:@"0"];
     ZMFieldModel *fieldModel8 = [[ZMFieldModel alloc] initWithTitle:@"竞技健美" imageName:@"image09" status:@"0"];
    self.dataSource = @[fieldModel,fieldModel1,fieldModel2,fieldModel3,fieldModel4,fieldModel5,fieldModel6,fieldModel7,fieldModel8].mutableCopy;
    [self.view addSubview:self.collectionView];
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
    [self.collectionView reloadData];
}

@end
