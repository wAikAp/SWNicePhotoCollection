//
//  SWPhotoBrowser.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/12.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWPhotoBrowser.h"
#import "SWBrowserCell.h"
#import "SWPhoto.h"
#import "UIView+SWUtility.h"
#import "SWImageView.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *cellID = @"SWBrowserCell";

@interface SWPhotoBrowser() <UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,SWBrowserCellDelegate>

@property (nonatomic, strong) UICollectionView *photoScrollView;

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayOut;

/**
 *  来源imageView
 */
@property (nonatomic, assign) CGRect srcImageView_frame;

@property (nonatomic, strong) UIImageView *cell_ImageView;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UILabel *indexLabel;

@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation SWPhotoBrowser

-(instancetype)init
{
    if (self = [super init]) {
//        self.handleVcontroller = [[SWPhotoBrowserViewController alloc]initWithView:self];
        
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        CGRect frame = self.bounds;
        //背景
        _backGroundView = [[UIView alloc]initWithFrame:frame];
        _backGroundView.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_backGroundView];
        _backGroundView.alpha = 0;
        
        //collection
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
        _photoScrollView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayOut];
        _photoScrollView.pagingEnabled = YES;
        _photoScrollView.delegate = self;
        _photoScrollView.dataSource = self;
        _photoScrollView.showsHorizontalScrollIndicator = NO;
        _photoScrollView.showsVerticalScrollIndicator = NO;
        _photoScrollView.backgroundColor = [UIColor clearColor];
        
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayOut.minimumLineSpacing = 20;
        flowLayOut.minimumInteritemSpacing = 0;

        CGFloat lineSpacing = flowLayOut.minimumLineSpacing;
        _photoScrollView.sw_width += lineSpacing;
        _photoScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, lineSpacing);
        
        [_photoScrollView registerClass:[SWBrowserCell class] forCellWithReuseIdentifier:cellID];
        
        //加入collectionView
        [self addSubview:_photoScrollView];
        
    }
    return self;
}


/**
 *  显示
 */
-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //当前显示的图片模型
    SWPhoto *photo = self.photos[self.currentPhotoIndex];
    
    //复制来源View
    UIImageView *srcImageView = [[UIImageView alloc]init];
    srcImageView.image = photo.srcImageView.image;
    
    //转变frame 拿到当前View在父View的frame
    srcImageView.frame = [[photo.srcImageView superview] convertRect:photo.srcImageView.frame toView:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentPhotoIndex inSection:0];
    
    if (self.photos.count > 1) {//大于一张才显示
        
        if (self.showItemType == typeIndexLabel ) {//label
            
            //显示多少张 label
            UILabel *indexLabel = [[UILabel alloc]init];
            indexLabel.text = [NSString stringWithFormat:@"%ld / %ld",indexPath.item +1 ,self.photos.count];
            indexLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 50 , WIDTH, 50);
            indexLabel.textAlignment = NSTextAlignmentCenter;
            indexLabel.textColor = [UIColor whiteColor];
            indexLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];//加粗
            self.indexLabel = indexLabel;
            
        }else{//默认 page 
            
            //pageControl
            UIPageControl *pageControl = [[UIPageControl alloc]init];
            pageControl.numberOfPages = self.photos.count;
            pageControl.currentPage = indexPath.item;
            pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 50 , WIDTH, 50);
            pageControl.userInteractionEnabled = NO;
            self.pageControl = pageControl;
        }
    }
    //跳到指定图片下标
    [self.photoScrollView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    //图片太小的话变成1/3
    CGFloat moRenImageHight = sWSrceen_HEIGHT /3;
    CGFloat imageHight = srcImageView.image.size.height;
    CGFloat bigAlp = 1.0;
    //复制的image
    srcImageView.sw_height = sWSrceen_HEIGHT / 5;
    
    if (imageHight >= sWSrceen_HEIGHT/2 && imageHight <= sWSrceen_HEIGHT) {//比屏幕一半大
       
        srcImageView.contentMode = UIViewContentModeScaleToFill;
        
    }else if (imageHight > sWSrceen_HEIGHT){//长图
        imageHight +=moRenImageHight;
        srcImageView.contentMode = UIViewContentModeScaleAspectFit;
        bigAlp = 0.7;
        
    }else if (imageHight < sWSrceen_HEIGHT/2){//比屏幕1/2还小
        
        imageHight  = moRenImageHight; //就变成1/3
        srcImageView.contentMode = UIViewContentModeScaleToFill;
    }
    [window addSubview:srcImageView];
    _backGroundView.alpha = 0.1f;
    [UIView animateWithDuration:0.35 animations:^{
        _backGroundView.alpha = 1.0f;
        //变大
        srcImageView.sw_size = CGSizeMake(sWSrceen_WIDTH , imageHight);
        srcImageView.center = CGPointMake(sWSrceen_WIDTH/ 2, sWSrceen_HEIGHT/2);
        srcImageView.alpha = bigAlp;

    } completion:^(BOOL finished) {
        
        [srcImageView removeFromSuperview];//移除复制的image
        [window addSubview:self];//添加自己
        _indexLabel? [window addSubview:_indexLabel] : nil;
        _pageControl? [window addSubview:_pageControl] : nil;
    }];
}

#pragma mark - dataSoure
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SWPhoto *photo = self.photos[indexPath.item];
    SWBrowserCell *cell = [[SWBrowserCell alloc]initWithCollectionView:collectionView cellID:cellID indexPath:indexPath photo:photo];
    //取出模型
    cell.delegate = self;
    return cell;
}

#pragma mark - celldelegate
-(void)browserCellDidTap:(UIImageView *)imageView andCell:(SWBrowserCell *)cell
{
    //拿到当前显示的indexpath
    NSIndexPath *indexPath = [self.photoScrollView indexPathForCell:cell];
    SWPhoto *tapPhoto = self.photos[indexPath.item];
    
    //拿出cell的imageView
    self.cell_ImageView = imageView;
    
    //存起本来的没放大的frame
    self.srcImageView_frame = [[tapPhoto.srcImageView superview] convertRect:tapPhoto.srcImageView.frame toView:[UIApplication sharedApplication].keyWindow];

    //把自己移除当前window 变小
    [UIView animateWithDuration:0.35 animations:^{ //开始动画
        _backGroundView.alpha = 0.8;        
        CGFloat src_width = self.srcImageView_frame.size.width;
        self.cell_ImageView.sw_width = src_width ;
        self.cell_ImageView.sw_height = src_width ;
        self.cell_ImageView.sw_origin = self.srcImageView_frame.origin;

        _backGroundView.alpha = 0.0;
        [self.indexLabel removeFromSuperview];
        [_pageControl removeFromSuperview];
    } completion:^(BOOL finished) {
        //移除自己
        [_backGroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark <UICollectionViewDelegateFlowLayout>
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //中心点
    CGPoint referencePoint = scrollView.center;
    referencePoint.x += scrollView.contentOffset.x;
    
    NSArray *indxArr = [self.photoScrollView indexPathsForVisibleItems];
    for (NSIndexPath *indexPath in indxArr) {
        
        SWBrowserCell *cell = (SWBrowserCell *)[self.photoScrollView cellForItemAtIndexPath:indexPath];
        //设置页数label
        if (CGRectContainsPoint(cell.frame, referencePoint)) {

            self.indexLabel.text = [NSString stringWithFormat:@"%ld / %ld",indexPath.item +1,self.photos.count];
            self.pageControl.currentPage = indexPath.item;
            break;
        }
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(sWSrceen_WIDTH, sWSrceen_HEIGHT);
}

-(void)dealloc
{
    NSLog(@"SWPhotoBrowser_dealloc - SW图片浏览器释放");
}


@end
