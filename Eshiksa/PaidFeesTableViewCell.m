//
//  PaidFeesTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 07/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "PaidFeesTableViewCell.h"

@implementation PaidFeesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.invoiceBtn.layer.masksToBounds=YES;
    self.invoiceBtn.layer.cornerRadius=8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
