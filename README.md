# SWNicePhotoCollection
One code finish Images Speed Dial LayOut & PhotoBrowser / 一句代码搞定九宫格布局图片 + 图片浏览器

一句代码搞定九宫格布局
+(instancetype)nicePhotoWithImageArray:(NSArray *)imageArray;


直接把存有图片的数组初始化 自动布局九宫格 自动算行列大小 

微信/微博 九宫格效果 

依赖第三方Masonry


#SWPhotoBrowser


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
SWPhotoBrowser *browser = [[SWPhotoBrowser alloc]init];
browser.photos = photoArr;
browser.currentPhotoIndex = indexPath.item;
[browser show];