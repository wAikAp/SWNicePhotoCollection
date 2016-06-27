//
//  SWCollectionViewImageCell.h
//  SleepTest
//
//  Created by shingwai chan on 16/5/19.
//  Copyright © 2016年 ShingWai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SWCollectionViewImageCell : UICollectionViewCell
/**
 *  图片
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  图片View
 */
@property (nonatomic, strong) UIImageView *imageView;
@end
