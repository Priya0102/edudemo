//
//  HomeWorkTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "HomeWorkTableViewCell.h"

@implementation HomeWorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.downloadBtn.layer.masksToBounds=YES;
    self.downloadBtn.layer.cornerRadius=8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
