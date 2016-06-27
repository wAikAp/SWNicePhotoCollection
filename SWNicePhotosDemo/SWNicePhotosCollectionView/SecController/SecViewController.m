//
//  SecViewController.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/6.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SecViewController.h"
#import "SWNicePhotosCollectionView.h"

#import "UIView+SWUtility.h"

#import "Masonry.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片数组
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i < 9; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i]];
        [imageArr addObject:image];
    }
    
    //九宫格View
    SWNicePhotosCollectionView *nicePhoto = [SWNicePhotosCollectionView nicePhotoWithImageArray:imageArr];
    [self.view addSubview:nicePhoto];
    
    [nicePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.leading.mas_equalTo(self.view).offset(10);
    }];
    
    
}



@end
