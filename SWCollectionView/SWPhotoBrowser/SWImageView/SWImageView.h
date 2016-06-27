//
//  SWImageView.h
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 16/6/23.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWImageView;
@protocol SWImageViewDelegate <NSObject>
//点击图片
-(void)imageViewDidTap:(UIImageView *)imageView;

-(void)imageViewDidDoubleTap:(SWImageView *)srcImageView;
//保存完成回调
-(void)imageDidFinishSaveToAlbum:(UIImage *)image;

@end


@class SWPhoto;
@interface SWImageView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) SWPhoto *photo;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, weak) id<SWImageViewDelegate> imageViewDelegate;

@end
