//
//  SWBrowserCell.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/12.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWBrowserCell.h"
#import "SWPhoto.h"
#import "UIView+SWUtility.h"
#import "SWImageView.h"

@interface  SWBrowserCell() <UIScrollViewDelegate,SWImageViewDelegate>

@property (nonatomic, strong) SWImageView *scImageView;
@end

@implementation SWBrowserCell

-(SWImageView *)scImageView
{
    if (_scImageView == nil) {
        _scImageView = [[SWImageView alloc]initWithFrame:CGRectMake(0, 0, sWSrceen_WIDTH, sWSrceen_HEIGHT)];
        [self addSubview:_scImageView];
    }
    return _scImageView;
}

-(instancetype)initWithCollectionView:(UICollectionView *)collView cellID:(NSString *)cellID indexPath:(NSIndexPath *)indexPath photo:(SWPhoto *)photo;
{
    SWBrowserCell *cell = [collView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.photo = photo;
    cell.backgroundColor = [UIColor clearColor];
    cell.scImageView.imageViewDelegate = cell;
    cell.scImageView.photo = photo;
    
    return cell;
}

#pragma mark - 手势scImageView.imageViewDelegate

-(void)imageViewDidTap:(UIImageView *)imageView{
    
    if ([self.delegate respondsToSelector:@selector(browserCellDidTap:andCell:)]) {

        [self.delegate browserCellDidTap:imageView andCell:self];
    }

}

-(void)imageViewDidDoubleTap:(SWImageView *)srcImageView {


}

-(void)imageDidFinishSaveToAlbum:(UIImage *)image
{
    
}

@end
