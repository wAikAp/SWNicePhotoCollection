# SWNicePhotoCollection
One code finish Images Speed Dial LayOut & PhotoBrowser / one line code

+(instancetype)nicePhotoWithImageArray:(NSArray *)imageArray;


#SWPhotoBrowser


NSMutableArray *photoArr = [NSMutableArray array];

for (int i = 0; i < self.imageArray.count; ++i) {

SWPhoto *photo = [[SWPhoto alloc]init];

photo.image = self.imageArray[i];

NSIndexPath *index_Path = [NSIndexPath indexPathForItem:i inSection:0];
SWCollectionViewImageCell *cell = (SWCollectionViewImageCell *)[collectionView cellForItemAtIndexPath:index_Path];
photo.srcImageView = cell.imageView;

[photoArr addObject:photo];
}

SWPhotoBrowser *browser = [[SWPhotoBrowser alloc]init];
browser.photos = photoArr;
browser.currentPhotoIndex = indexPath.item;
[browser show];
