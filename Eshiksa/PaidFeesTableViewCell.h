//
//  PaidFeesTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 07/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaidFeesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *billNumber;
@property (weak, nonatomic) IBOutlet UILabel *createdDate;
@property (weak, nonatomic) IBOutlet UILabel *feesName;
@property (weak, nonatomic) IBOutlet UILabel *payStatus;
@property (weak, nonatomic) IBOutlet UIButton *invoiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *feesAmount;
@property (weak, nonatomic) IBOutlet UILabel *fineAmount;
@property (weak, nonatomic) IBOutlet UILabel *paidAmount;
@property (weak, nonatomic) IBOutlet UILabel *feesReciept;
@property (weak, nonatomic) IBOutlet UILabel *feesRecieptUrl;
@end
