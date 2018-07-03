//
//  ZMPickPhotoCollectionView.h
//  Fish
//
//  Created by zhaoming on 28/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickPhotoCollectionViewDelegate

@optional
- (void)DidAddNewPhoto;

- (void)didRemoveOriginPhoto;

@end

@interface ZMPickPhotoCollectionView : UIView
@property (nonatomic, weak) id <PickPhotoCollectionViewDelegate> delegate;
@property (nonatomic, strong) NSArray * photoUrls;

@property (nonatomic, strong, readonly) NSMutableArray *photos;


@end
