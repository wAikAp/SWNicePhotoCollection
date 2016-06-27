//
//  SWPhoto.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/12.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWPhoto.h"

@implementation SWPhoto


#pragma mark 截图
- (UIImage *)capture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//- (void)setSrcImageView:(UIImageView *)srcImageView
//{
//    _srcImageView = srcImageView;
//    _placeholder = srcImageView.image;
//    if (srcImageView.clipsToBounds) {
//        _capture = [self capture:srcImageView];
//    }
//}
@end
