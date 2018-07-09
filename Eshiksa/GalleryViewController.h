//
//  GalleryViewController.h
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSMutableArray *galleryArr,*foldernameArr,*imgIdArr,*folderIdArr;
@property(nonatomic,retain)NSString *indxp,*folderIdStr,*titleStr;

@end
