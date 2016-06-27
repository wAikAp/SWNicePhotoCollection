//
//  SWPhotoBrowser.h
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/12.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  显示label 还是pageControl 默认pageControl
 */
typedef NS_OPTIONS(NSInteger, browShowItemPageNumType) {
    /**
     *  label
     */
    typeIndexLabel = 1,
    /**
     *  pageControl
     */
    typePageControl = 2
};



@interface SWPhotoBrowser : UIView

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (nonatomic, assign) browShowItemPageNumType showItemType;

-(void)show;


@end
