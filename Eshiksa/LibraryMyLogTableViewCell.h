//
//  LibraryMyLogTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 12/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryMyLogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookname;
@property (weak, nonatomic) IBOutlet UILabel *issuedDate;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (weak, nonatomic) IBOutlet UILabel *fineAmt;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@end
