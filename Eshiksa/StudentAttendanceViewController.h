//
//  StudentAttendanceViewController.h
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentAttendanceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *totalLecture;
@property (weak, nonatomic) IBOutlet UILabel *presentLecture;
@property (weak, nonatomic) IBOutlet UILabel *absentLecture;

@property(nonatomic,retain)NSString *tag,*success,*error,*rollnumber,*attendance;

@property (nonatomic,strong) NSString *totalLecturestr,*presentLecturestr,*absentLecturestr;
@property (weak, nonatomic) IBOutlet UILabel *totalLectureTxt;
@property (weak, nonatomic) IBOutlet UILabel *presentTxt;
@property (weak, nonatomic) IBOutlet UILabel *absentTxt;

@end
