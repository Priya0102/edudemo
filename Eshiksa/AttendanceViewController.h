//
//  AttendanceViewController.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "DropdownMenuSegue.h"
#import "RzTextField.h"

@interface AttendanceViewController : UIViewController<UIScrollViewDelegate,NIDropDownDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *courseBtnSelect;
    IBOutlet UIButton *batchBtnSelect;
    IBOutlet UIButton *sectionBtnSelect;
    IBOutlet UIButton *subjectBtnSelect;
    IBOutlet RzTextField *dateTxtField;
    
    NIDropDown *dropDown1,*dropDown2,*dropDown3,*dropDown4;
}
@property (strong,nonatomic) NSString *courseNameStr,*courseIdStr,*teacherIdStr,*batchNameStr,*batchIdStr,*sectionIdStr,*sectionNameStr,*subNameStr,*subIdStr;
@property (weak, nonatomic) IBOutlet UILabel *selectCourseBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectBatchLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectSectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectSubLbl;

@property (weak, nonatomic) IBOutlet UILabel *takeAttendancetxt;
@property (weak, nonatomic) IBOutlet UILabel *coursetxt;
@property (weak, nonatomic) IBOutlet UILabel *batchtxt;
@property (weak, nonatomic) IBOutlet UILabel *sectiontxt;
@property (weak, nonatomic) IBOutlet UILabel *subjecttxt;
@property (weak, nonatomic) IBOutlet UILabel *datetxt;
@property (weak, nonatomic) IBOutlet UILabel *fetchStudenttxt;
@property (weak, nonatomic) IBOutlet UIButton *fetchStudentBtn;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *courseIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *teacherIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *batchNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *batchIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *sectionNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *sectionIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *subNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subIdLbl;

@end
