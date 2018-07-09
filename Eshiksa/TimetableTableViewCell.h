//
//  TimetableTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimetableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lectureTiming;
@property (weak, nonatomic) IBOutlet UILabel *lectureName;
@property (weak, nonatomic) IBOutlet UILabel *subjectname;
@property (weak, nonatomic) IBOutlet UILabel *subjectId;
@property (weak, nonatomic) IBOutlet UILabel *day;


@end
