//
//  ZMSuccessDemoCollectionViewController.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSuccessDemoCollectionViewController.h"

@interface ZMSuccessDemoCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZMSuccessDemoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

//- (instancetype)init {
//   
//    if (self = [super initWithCollectionViewLayout:flowLayout]) {       
//    }
//    return self;
//}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 48) / 3, 90);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 10, 16);
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 47);
        flowLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView r:[UINib nibWithNibName:@"ZMSuccessDemoSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZMSuccessDemoSectionHeaderView"];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader forCellWithReuseIdentifier:@"ZMSuccessDemoSectionHeaderView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZMSuccessDemoSectionHeaderView"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ZMSuccessDemoSectionFooterView"];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"ZMSuccessDemoSectionFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ZMSuccessDemoSectionFooterView"];
}





#pragma mark <UICollectionViewDataSource>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZMSuccessDemoSectionHeaderView" forIndexPath:indexPath];
        UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ZMSuccessDemoSectionHeaderView" owner:nil options:nil].firstObject;
        headerView.frame = view.bounds;
        [view addSubview:headerView];

        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZMSuccessDemoSectionFooterView" forIndexPath:indexPath];
        UIView *footerView = [[NSBundle mainBundle] loadNibNamed:@"ZMSuccessDemoSectionFooterView" owner:nil options:nil].firstObject;
        footerView.frame = view.bounds;
        [view addSubview:footerView];
        return view;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    imageView.image = [UIImage imageNamed:@"Bitmap2"];
    [cell addSubview:imageView];
    
    return cell;
}



@end
