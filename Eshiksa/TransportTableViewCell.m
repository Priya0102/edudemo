//
//  TransportTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 14/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "TransportTableViewCell.h"

@implementation TransportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewMapBtn.layer.masksToBounds=YES;
    self.viewMapBtn.layer.cornerRadius=8;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_statusLbl.bounds
                                                   byRoundingCorners:( UIRectCornerBottomLeft)
                                                         cornerRadii:CGSizeMake(8.0, 8.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _statusLbl.bounds;
    maskLayer.path = maskPath.CGPath;
    _statusLbl.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
