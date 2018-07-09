//
//  ViewRequistionTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 26/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "ViewRequistionTableViewCell.h"

@implementation ViewRequistionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _statusLabel.layer.masksToBounds=YES;
    _statusLabel.layer.cornerRadius=8.0;
    
    _statusBtn.layer.masksToBounds=YES;
    _statusBtn.layer.cornerRadius=8.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
