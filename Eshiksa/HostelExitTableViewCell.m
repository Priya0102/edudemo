//
//  HostelExitTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 02/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "HostelExitTableViewCell.h"

@implementation HostelExitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _popUpView.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)showAnimate
{
    self.contentView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.contentView.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    _popUpView.hidden=YES;
}
- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.contentView];
    if (animated) {
        [self showAnimate];
    }
}
- (IBAction)statusBtnClicked:(id)sender {
    
    _popUpView.hidden=NO;
    
}


@end
