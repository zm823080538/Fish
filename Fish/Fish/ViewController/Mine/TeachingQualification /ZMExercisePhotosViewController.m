//
//  ZMExercisePhotosViewController.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMExercisePhotosViewController.h"
#import "ZMPickPhotoCollectionView.h"
@interface ZMExercisePhotosViewController ()
@property (weak, nonatomic) IBOutlet ZMPickPhotoCollectionView *photoView;

@end

@implementation ZMExercisePhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健身照";    
}


@end
