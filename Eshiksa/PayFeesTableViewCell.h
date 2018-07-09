//
//  PayFeesTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 08/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import <UIKit/UIKit.h>

@interface PayFeesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fees_name;
@property (weak, nonatomic) IBOutlet UILabel *fees_amount;
@property (weak, nonatomic) IBOutlet UILabel *due_date;
@property (weak, nonatomic) IBOutlet UILabel *due_amount;

@property (weak, nonatomic) IBOutlet UILabel *paid_amount;
@property (weak, nonatomic) IBOutlet UILabel *total_concession_amount;
@property (weak, nonatomic) IBOutlet UILabel *head_fine_amount;
@property (weak, nonatomic) IBOutlet UILabel *payNowBtn;

@property (weak, nonatomic) IBOutlet UILabel *courseid;
@property (weak, nonatomic) IBOutlet UILabel *batchid;
@property (weak, nonatomic) IBOutlet UILabel *departmentId;
@property (weak, nonatomic) IBOutlet UILabel *sessionId;
@property (weak, nonatomic) IBOutlet UILabel *studentId;
@property (weak, nonatomic) IBOutlet UILabel *feesId;
@property (weak, nonatomic) IBOutlet UILabel *onlinepayDiscountAmt;

@end
