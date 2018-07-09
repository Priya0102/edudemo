//
//  StudentHomeworkTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 04/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "StudentHomeworkTableViewCell.h"

@implementation StudentHomeworkTableViewCell

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
