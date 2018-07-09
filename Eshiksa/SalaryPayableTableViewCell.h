//
//  SalaryPayableTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 27/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalaryPayableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *payableName;
@property (weak, nonatomic) IBOutlet UILabel *payableAmt;

@end
