//
//  SWPhotoBrowserViewController.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 16/6/27.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWPhotoBrowserViewController.h"
#import "SWPhotoBrowser.h"

@interface SWPhotoBrowserViewController ()

@property (nonatomic, strong) SWPhotoBrowser *browser;

@end

@implementation SWPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.browser = [[SWPhotoBrowser alloc]init];
    self.browser.photos = self.photos;
    self.browser.currentPhotoIndex = self.currentPhotoIndex;
//    self.browser.showItemType = self.showItemType;//底部显示第几张的类型
    NSLog(@"self = %@",self.browser);
}

-(void)show
{
    [self.browser show];//显示完后 变成以显示
}


@end
