//
//  SWNicePhotosCollectionView.m
//  SWNicePhotosCollectionView
//
//  Created by shingwai chan on 2016/6/6.
//  Copyright © 2016年 ShingWai帅威. All rights reserved.
//

#import "SWNicePhotosCollectionView.h"
#import "SWCollectionViewImageCell.h"


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
        
        CGSize size = CGSizeMake(180, 120);
        
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWCollectionViewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collCell" forIndexPath:indexPath];
    cell.image = self.imageArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
}


@end


