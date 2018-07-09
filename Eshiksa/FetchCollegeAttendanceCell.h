//
//  FetchCollegeAttendanceCell.h
//  Eshiksa
//
//  Created by Punit on 12/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchCollegeAttendanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *studentFullName;
@property (weak, nonatomic) IBOutlet UILabel *rollNum;
@property (weak, nonatomic) IBOutlet UILabel *studentId;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property(weak,nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UIButton *studentSelectBtn;
@property(weak,nonatomic) IBOutlet UILabel *attendanceStatus;

@end
