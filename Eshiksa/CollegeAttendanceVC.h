//
//  CollegeAttendanceVC.h
//  Eshiksa
//
//  Created by Punit on 05/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RzTextField.h"
#import "NIDropDown.h"
@interface CollegeAttendanceVC : UIViewController<UITextFieldDelegate,NIDropDownDelegate>
{
    IBOutlet UIButton *courseBtnSelect;
    IBOutlet UIButton *batchBtnSelect;
     IBOutlet UIButton *departmentBtnSelect;
    IBOutlet UIButton *lectureBtnSelect;
    IBOutlet UIButton *semesterBtnSelect;
    IBOutlet UIButton *sectionBtnSelect;
    IBOutlet UIButton *subjectBtnSelect;
     IBOutlet RzTextField *dateTxtField;
     NIDropDown *dropDown1,*dropDown2,*dropDown3,*dropDown4,*dropDown5,*dropDown6,*dropDown7;
}
@property (weak, nonatomic) IBOutlet UILabel *selectCourseBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectBatchLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectDepartmentBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectSemesterBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectSectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectSubLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectLectureBtnLbl;

@property (weak, nonatomic) IBOutlet UILabel *takeattendancetxt;
@property (weak, nonatomic) IBOutlet UILabel *coursetxt;
@property (weak, nonatomic) IBOutlet UILabel *basetxt;
@property (weak, nonatomic) IBOutlet UILabel *departmenttxt;
@property (weak, nonatomic) IBOutlet UILabel *semestertxt;
@property (weak, nonatomic) IBOutlet UILabel *sectiontxt;
@property (weak, nonatomic) IBOutlet UILabel *subjecttxt;
@property (weak, nonatomic) IBOutlet UILabel *datetxt;
@property (weak, nonatomic) IBOutlet UILabel *fetchStudentTxt;
@property (weak, nonatomic) IBOutlet UIButton *fetchStudentBtn;
@property (weak, nonatomic) IBOutlet UIButton *lectureTxt;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *courseIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *teacherIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *batchNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *batchIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *departmentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *departmentIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *semesterNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *semesterIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *sectionNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *sectionIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *sessionIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *sessionnameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *lectureNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *lectureIdLbl;


@property (strong,nonatomic) NSString *courseNameStr,*courseIdStr,*teacherIdStr,*batchNameStr,*batchIdStr,*sectionIdStr,*sectionNameStr,*subNameStr,*subIdStr,*departmentIdStr,*departmentLblStr,*semesterIdStr,*semesterLblStr,*sessionIdStr,*sessionNameStr,*lectureIdStr,*lectureLblStr;

@end
