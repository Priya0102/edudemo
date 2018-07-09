//
//  GalleryCollectionViewCell.m
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

@implementation GalleryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.foldername.layer.masksToBounds=YES;
    self.foldername.layer.cornerRadius=8;
}


@end
