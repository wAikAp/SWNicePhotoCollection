//
//  SWBrowserCell.h
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/12.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWImageView;
@class SWBrowserCell;
@protocol SWBrowserCellDelegate <NSObject>

-(void)browserCellDidTap:(UIImageView *)imageView andCell:(SWBrowserCell *)cell;

@end

@class SWPhoto;
@interface SWBrowserCell : UICollectionViewCell
/**
 *  photo模型
 */
@property (nonatomic, strong) SWPhoto *photo;
/**
 *  代理
 */
@property (nonatomic, weak) id<SWBrowserCellDelegate> delegate;

@property (nonatomic, strong) SWImageView *srcImageView;

//初始化
-(instancetype)initWithCollectionView:(UICollectionView *)collView cellID:(NSString *)cellID indexPath:(NSIndexPath *)indexPath photo:(SWPhoto *)photo;

@end
