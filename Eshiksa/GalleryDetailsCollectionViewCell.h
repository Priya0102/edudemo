//
//  GalleryDetailsCollectionViewCell.h
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryDetailsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UIView *viewLbl;
@property (weak, nonatomic) IBOutlet UILabel *subfolderName;

@end
