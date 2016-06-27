//
//  SWNicePhotosCollectionView.h
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/6.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  九宫格collectionView
 */
@interface SWNicePhotosCollectionView : UICollectionView


/**
 *  初始化 直接把大图数组放进来
 *
 *  @param imageArray 图片数组
 *
 */
+(instancetype)nicePhotoWithImageArray:(NSArray *)imageArray;

/**
 *  image 大图片数组 最多9张 
 */
@property (nonatomic, strong) NSArray *imageArray;


/**
 *  图片浏览器的下标类型 1为数字label 2为pageControl 默认pageControl
 */
@property (nonatomic, assign) NSInteger browShowItemPageNumType;


@end
