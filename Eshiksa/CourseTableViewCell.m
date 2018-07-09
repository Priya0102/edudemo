//
//  CourseTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 09/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "CourseTableViewCell.h"

@implementation CourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:_firstView.bounds
                                                    byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                          cornerRadii:CGSizeMake(8.0, 8.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer2 = [CAShapeLayer layer];
    maskLayer2.frame = _firstView.bounds;
    maskLayer2.path = maskPath2.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _firstView.layer.mask = maskLayer2;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
