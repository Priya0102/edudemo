//
//  PayFeesTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 08/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "PayFeesTableViewCell.h"

@implementation PayFeesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.payNowBtn.layer.masksToBounds=YES;
    self.payNowBtn.layer.cornerRadius=8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
