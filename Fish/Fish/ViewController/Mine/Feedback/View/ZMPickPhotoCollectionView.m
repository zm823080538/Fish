//
//  ZMPickPhotoCollectionView.m
//  Fish
//
//  Created by zhaoming on 28/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMPickPhotoCollectionView.h"
#import "YPImagePicker.h"
#import <UIView+YYAdd.h>
#import "UIViewController+CurrentViewController.h"

@interface ZMPickPhotoCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMPickPhotoCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.photos = @[].mutableCopy;
    [self addSubview:self.collectionView];
}

- (void)setPhotoUrls:(NSArray *)photoUrls {
    _photoUrls = photoUrls;
    [self.collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader" forIndexPath:indexPath];
        [view addSubview:[self configFooterView]];
        return view;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.photoUrls) {
        return self.photoUrls.count + 1;
    }
    return self.photos.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMPickPhotoCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView removeAllSubviews];
    if (indexPath.item == 0) {
        [cell.contentView addSubview:[self configFooterView]];
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        if (self.photoUrls) {
            [imageView setImageWithURL:[NSURL URLWithString:self.photoUrls[indexPath.item - 1]] placeholder:PlaceholderImage];
        } else {
            imageView.image = self.photos[indexPath.item - 1];
        }
        [cell.contentView addSubview:imageView];
    }
    return cell;
}

- (UIButton *)configFooterView {
    UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    footerButton.frame = CGRectMake(0, 0, 94, 94);
    [footerButton setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(footerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return footerButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(94, 94);
        flowLayout.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ZMPickPhotoCollectionViewCell"];
    }
    return _collectionView;
}

- (void)footerButtonClick {
    [YPImagePicker pickSingleImageWithTitle:@"上传图片" allowEditing:YES inViewController:[UIViewController getCurrentVC] completionBlock:^(UIImage *image) {
        [self.photos addObject:image];
        [self.collectionView reloadData];
    }];
}

@end
