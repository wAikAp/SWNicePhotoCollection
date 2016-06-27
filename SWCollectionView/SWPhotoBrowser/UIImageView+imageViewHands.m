//
//  UIImageView+imageViewHands.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 16/6/27.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "UIImageView+imageViewHands.h"

@implementation UIImage (imageViewHands)


- (UIImage *)rescaleImageToSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];  // scales image to rect
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}

@end
