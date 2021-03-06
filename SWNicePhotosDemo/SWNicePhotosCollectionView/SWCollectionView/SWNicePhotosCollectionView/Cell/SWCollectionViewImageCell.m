//
//  SWCollectionViewImageCell.m
//  SleepTest
//
//  Created by shingwai chan on 16/5/19.
//  Copyright © 2016年 ShingWai. All rights reserved.
//

#import "SWCollectionViewImageCell.h"

@interface SWCollectionViewImageCell ()

@end

@implementation SWCollectionViewImageCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageView];
        
        self.imageView.frame = self.bounds;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithImage:nil];
    }
    return _imageView;
}

@end
