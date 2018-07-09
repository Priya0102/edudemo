//
//  GalleryVideoCollectionViewCell.m
//  Eshiksa
//
//  Created by Punit on 04/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GalleryVideoCollectionViewCell.h"

@implementation GalleryVideoCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewLbl.layer.masksToBounds=YES;
    self.viewLbl.layer.cornerRadius=8;
    
}
@end
