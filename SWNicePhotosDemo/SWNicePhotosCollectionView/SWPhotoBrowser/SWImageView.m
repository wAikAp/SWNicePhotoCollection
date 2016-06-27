//
//  SWImageView.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 16/6/23.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWImageView.h"

#import "SWPhoto.h"

#import "UIView+SWUtility.h"
#import "UIImageView+imageViewHands.h"
#import "Masonry.h"


@interface SWImageView() <UIActionSheetDelegate , UIImagePickerControllerDelegate>

@property (nonatomic, assign) CGFloat currentScale;

@property (nonatomic, assign) CGFloat imageHeight;

@end

@implementation SWImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sWSrceen_WIDTH, sWSrceen_HEIGHT)];
        //        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        _currentScale = 1;
        
        // 属性
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.minimumZoomScale = 1.f;
        self.maximumZoomScale = 3.f;
        self.bounces = YES;
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMon:)];
        
        tap.delaysTouchesBegan = YES;
        tap.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:tap];
        //双击
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer:doubleTap];
        //只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
        [tap requireGestureRecognizerToFail:doubleTap];
        
        //长按
        UILongPressGestureRecognizer *longGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longGest2SaveImage:)];
        [self addGestureRecognizer:longGest];
        
    }
    return self;
}

-(void)setPhoto:(SWPhoto *)photo
{
    _imageView.frame = CGRectMake(0, 0, sWSrceen_WIDTH, sWSrceen_HEIGHT);
    _imageView.contentMode = UIViewContentModeScaleToFill;
    self.contentSize = CGSizeMake(0, 0);
    [self setZoomScale:1 animated:NO];
    _photo = photo;
    _imageView.image = photo.image;
    CGFloat imageHeight = photo.image.size.height;
    
    if (imageHeight < sWSrceen_HEIGHT/2) {//图片如果少于屏幕1/2
        
        imageHeight = sWSrceen_HEIGHT/3;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.contentMode = UIViewContentModeScaleToFill;
        //原比例返回改变size后的image
        _imageView.image = [photo.image rescaleImageToSize:CGSizeMake(sWSrceen_WIDTH,  imageHeight)];
        _imageView.sw_height = imageHeight;
        _imageView.sw_width = sWSrceen_WIDTH;
        _imageView.center  = CGPointMake(sWSrceen_WIDTH/2, sWSrceen_HEIGHT/2);
        
    }else if (imageHeight >  sWSrceen_HEIGHT ) {//图片大于屏幕时
        self.showsVerticalScrollIndicator = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.sw_height = imageHeight;
        _imageView.image = [photo.image rescaleImageToSize:CGSizeMake(sWSrceen_WIDTH,  imageHeight)];
        self.contentSize = CGSizeMake(sWSrceen_WIDTH,  imageHeight);//self.contentSize.height
        
    }else if (imageHeight >= sWSrceen_HEIGHT/2){//屏幕一半
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.sw_height = imageHeight;
        _imageView.sw_width = sWSrceen_WIDTH;
        _imageView.center  = CGPointMake(sWSrceen_WIDTH/2, sWSrceen_HEIGHT/2);
    }
    
    self.imageHeight = imageHeight;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - 手势
-(void)tapMon:(UITapGestureRecognizer *)tap {
    //点击回调
    if ([self.imageViewDelegate respondsToSelector:@selector(imageViewDidTap:)]) {//代理
        [self.imageViewDelegate imageViewDidTap:self.imageView];
    }
    
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    
    CGPoint touchPoint = [tap locationInView:self];
    
    if (_currentScale > 1.0) {//正常
        _currentScale = 1.0;
        [self setZoomScale:_currentScale animated:YES];
        
    }else{//放大
        
        _currentScale = 2;
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1.0f, 1.0f)  animated:YES];
        CGFloat contsizeW = self.contentSize.width;
        CGFloat contsizeH = self.contentSize.height;
        self.contentSize = CGSizeMake(contsizeW, contsizeH + self.imageHeight *2);
    }
}

-(void)longGest2SaveImage:(UILongPressGestureRecognizer*)longGest {
    
    if (longGest.state == UIGestureRecognizerStateBegan) {

        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片到相册", nil];
        [action showInView:[UIApplication sharedApplication].keyWindow];
        
    }

}

#pragma mark - scrollDelegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //两只手托时放大 给标示
    if (scrollView.contentOffset.x > 0 || scrollView.contentOffset.y > 0 ){//放大手势
        _currentScale = 2;
        
        CGFloat contsizeW = self.contentSize.width;
        CGFloat contsizeH = self.contentSize.height;
        //限制contsize
        if (self.imageHeight <= sWSrceen_HEIGHT / 2 && contsizeH <= sWSrceen_HEIGHT *1.5) {
//            NSLog(@"里面");
            contsizeH = self.contentSize.height + self.imageHeight*2;
            self.contentSize = CGSizeMake(contsizeW, contsizeH);
        }
    }else {//缩小手势
        _currentScale = 1;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//保存
        [self saveImage2Liber];
    }
}

-(void)saveImage2Liber{
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self,@selector(imagePickerController:didFinishPickingImage:editingInfo:), NULL);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [altView show];
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        
        [altView dismissWithClickedButtonIndex:0 animated:YES];
        if ([self.imageViewDelegate respondsToSelector:@selector(imageDidFinishSaveToAlbum:)]) {
            [self.imageViewDelegate imageDidFinishSaveToAlbum:image];
        }
    }];
}

/**
 *  返回当前正在显示的控制器
 *
 *  @return
 */
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

@end
