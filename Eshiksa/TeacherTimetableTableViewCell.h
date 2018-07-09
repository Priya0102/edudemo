//
//  TeacherTimetableTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 16/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherTimetableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lectureTiming;
@property (weak, nonatomic) IBOutlet UILabel *lectureName;
@property (weak, nonatomic) IBOutlet UILabel *subjectname;
@property (weak, nonatomic) IBOutlet UILabel *subjectId;
@property (weak, nonatomic) IBOutlet UILabel *day;
@end
