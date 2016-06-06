//
//  SecViewController.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/6.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SecViewController.h"
#import "SWNicePhotosCollectionView.h"
#import "Masonry.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //图片数组
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i < 9; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i]];
        [imageArr addObject:image];
    }
    //红色按钮
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomBtn];
    
    
    //九宫格View
    SWNicePhotosCollectionView *nicePhoto = [SWNicePhotosCollectionView nicePhotoWithImageArray:imageArr];
    [self.view addSubview:nicePhoto];
    
    //按钮约束
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(nicePhoto.mas_bottom);
    }];
    
}



@end
