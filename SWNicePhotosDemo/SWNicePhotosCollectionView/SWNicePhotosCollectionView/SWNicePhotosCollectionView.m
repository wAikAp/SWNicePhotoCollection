//
//  SWNicePhotosCollectionView.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/6.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWNicePhotosCollectionView.h"
#import "SWCollectionViewImageCell.h"

//第三方库
#import "Masonry.h"

#import "SWPhoto.h"
#import "SWPhotoBrowser.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

CGFloat cellMargin = 10;//cell间距
NSInteger maxColmun = 3;//最大行/列数

#define cellWh (WIDTH - 2 * cellMargin - (maxColmun - 1) * cellMargin )/ maxColmun // 图片宽高
#define pictureSize CGSizeMake(cellWh, cellWh);//size


@interface SWNicePhotosCollectionView() <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong)UICollectionViewFlowLayout *flowLayOut;

@end


@implementation SWNicePhotosCollectionView

#pragma mark - init
+(instancetype)nicePhotoWithImageArray:(NSArray *)imageArray
{
    
    SWNicePhotosCollectionView *pcV = [[SWNicePhotosCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    pcV.imageArray = imageArray;
    return pcV;
}



-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.flowLayOut = (UICollectionViewFlowLayout *)layout;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = NO;
        self.contentSize  = self.frame.size;
        [self registerClass:[SWCollectionViewImageCell class] forCellWithReuseIdentifier:@"collCell"];
        
    }
    return self;
}

#pragma mark - setter
-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    CGSize viewSize = [self viewSize];
    //更新collectionView的大小
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(viewSize);
    }];
    [self reloadData];
}


//返回collectionView的大小
- (CGSize )viewSize {
    
    NSInteger count = self.imageArray.count;
    
    if (count == 0) {
        return CGSizeZero;
    }
    
    if (count == 1) {
        
        CGSize size = CGSizeMake(WIDTH / 2 , HEIGHT / 5);
        
        self.flowLayOut.itemSize = size;
        self.flowLayOut.minimumLineSpacing = 0;
        self.flowLayOut.minimumInteritemSpacing = 0;
        return size;
    }
    //1张以上
    self.flowLayOut.itemSize = pictureSize;
    
    self.flowLayOut.minimumLineSpacing = cellMargin;
    self.flowLayOut.minimumInteritemSpacing = 0;
    
    //列数
    NSInteger cloumn = maxColmun;
    if ( count == 2 || count == 4 ) {//2张或者4张
        cloumn = 2;
    }
    
    //行数
    NSInteger row = (count + cloumn - 1) / cloumn;
    
    CGFloat width =  cloumn *cellWh + (cloumn - 1) * cellMargin;
    
    CGFloat height  = row * cellWh + (row - 1) * cellMargin + 5;
    //整个pictureView的大小
    //    NSLog(@"count = %ld\n cloumn = %ld\n  row = %ld\n  height = %f\n  width = %f\n  cellMArgin = %f",count , cloumn ,row ,height ,width ,cellMargin);
    return CGSizeMake(width, height);
}

#pragma mark - DataScore

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWCollectionViewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collCell" forIndexPath:indexPath];
    cell.image = self.imageArray[indexPath.row];
    return cell;
}

#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//
    NSMutableArray *photoArr = [NSMutableArray array];

    for (int i = 0; i < self.imageArray.count; ++i) {
        //创建photo
        SWPhoto *photo = [[SWPhoto alloc]init];
        //设置图片
        photo.image = self.imageArray[i];
        //来源哪里 每个图片i++ 不然直接用indexPath就永远都只来源于1个
        NSIndexPath *index_Path = [NSIndexPath indexPathForItem:i inSection:0];
        SWCollectionViewImageCell *cell = (SWCollectionViewImageCell *)[collectionView cellForItemAtIndexPath:index_Path];
        photo.srcImageView = cell.imageView;
        
        [photoArr addObject:photo];
    }
    //图片浏览器
    SWPhotoBrowser *pbrowser = [[SWPhotoBrowser alloc]init];
    pbrowser.photos = photoArr;
    pbrowser.currentPhotoIndex = indexPath.item;
    pbrowser.showItemType = typePageControl;//底部显示第几张的类型
    [pbrowser show];//显示完后 变成以显示
//    SWPhotoBrowserViewController *browserVc =[[SWPhotoBrowserViewController alloc]init];
//    browserVc.photos = photoArr;
//    browserVc.currentPhotoIndex = indexPath.item;
//    browserVc.showItemType = typePageControl;
//    [browserVc show];
//    self pre
    
}


@end


