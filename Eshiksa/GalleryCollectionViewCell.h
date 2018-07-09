//
//  GalleryCollectionViewCell.h
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView *galleryImgView;

@property (weak, nonatomic) IBOutlet UILabel *foldername;
@property (weak, nonatomic) IBOutlet UILabel *folderid;
@property (weak, nonatomic) IBOutlet UILabel *imageid;
@end
