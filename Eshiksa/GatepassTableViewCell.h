//
//  GatepassTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 28/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatepassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *createdDate;
@property (weak, nonatomic) IBOutlet UILabel *fromDate;

@property (weak, nonatomic) IBOutlet UILabel *toDate;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIButton *statusLblBtn;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

@end
