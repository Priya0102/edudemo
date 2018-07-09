//
//  GalleryVideoCollectionViewCell.h
//  Eshiksa
//
//  Created by Punit on 04/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryVideoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UIView *viewLbl;
@property (weak, nonatomic) IBOutlet UILabel *subfolderName;
@end
