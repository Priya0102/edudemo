//
//  GalleryDetailsCollectionViewCell.m
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GalleryDetailsCollectionViewCell.h"
#import "WebViewController.h"
@implementation GalleryDetailsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
self.viewLbl.layer.masksToBounds=YES;
self.viewLbl.layer.cornerRadius=8;

}

@end
