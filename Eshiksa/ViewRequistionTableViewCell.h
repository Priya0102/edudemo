//
//  ViewRequistionTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 26/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewRequistionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *requistionDate;
@property (strong, nonatomic) IBOutlet UILabel *requisitionType;
@property (strong, nonatomic) IBOutlet UILabel *requisitionDetails;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIButton *statusBtn;

@end
