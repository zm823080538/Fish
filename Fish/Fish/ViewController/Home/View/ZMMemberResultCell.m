//
//  ZMMemberResultCell.m
//  Fish
//
//  Created by zhaoming on 04/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMMemberResultCell.h"
#import "ZMMemberResultItemCell.h"
#import <UIImageView+YYWebImage.h>
#import <Masonry.h>
#import "ZMNewList.h"

@interface ZMMemberResultCell() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMMemberResultCell

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setArrayList:(NSArray *)arrayList {
    _arrayList = arrayList;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberResultItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMMemberResultItemCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    ZMNewListItem *item = self.arrayList[indexPath.item];
    [cell.imageView setImageWithURL:[NSURL URLWithString:item.image] placeholder:PlaceholderImage];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:item.userimg] placeholder:PlaceholderImage];
    cell.nameLabel.text = item.nickname;
    cell.titleLabel.text = item.title;
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(145, 271);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        flowLayout.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"ZMMemberResultItemCell" bundle:nil] forCellWithReuseIdentifier:@"ZMMemberResultItemCell"];
    }
    return _collectionView;
}


@end
