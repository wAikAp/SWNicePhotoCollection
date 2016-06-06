//
//  SWNicePhotosCollectionView.h
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/6.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import <UIKit/UIKit.h>


//用到了masonry库
#import "Masonry.h"

/**
 *  九宫格collectionView
 */
@interface SWNicePhotosCollectionView : UICollectionView


/**
 *  初始化
 *
 *  @param imageArray 图片数组
 *
 */
+(instancetype)nicePhotoWithImageArray:(NSArray *)imageArray;

/**
 *  image 图片数组 最多9张 
 */
@property (nonatomic, strong) NSArray *imageArray;





@end
