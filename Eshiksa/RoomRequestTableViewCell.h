//
//  RoomRequestTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 30/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomRequestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *statusBtnClicked;
@property (weak, nonatomic) IBOutlet UILabel *remarkDate;
@property (weak, nonatomic) IBOutlet UILabel *requestedStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UILabel *btnStatusLbl;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@end
