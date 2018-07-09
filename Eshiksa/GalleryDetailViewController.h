//
//  GalleryDetailViewController.h
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <SDWebImage/UIImageView+WebCache.h>
@interface GalleryDetailViewController :UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    dispatch_queue_t queue;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSMutableArray *galleryArr,*imgArr;
@property(nonatomic,retain)NSString *folderIdStr,*titleStr,*indxpath,*indxp;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*user;

@end
