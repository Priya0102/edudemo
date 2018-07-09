//
//  StudentProfileViewController.h
//  Eshiksa
//
//  Created by Punit on 24/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *profileview;
@property (weak, nonatomic) IBOutlet UIImageView *profilepicImg;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UILabel *upBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *downBtnLbl;
@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *batch;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *course;
@property (weak, nonatomic) IBOutlet UILabel *section;
@property (weak, nonatomic) IBOutlet UILabel *studentId;
@property (weak, nonatomic) IBOutlet UILabel *groupname;

@property (weak, nonatomic) IBOutlet UILabel *tag;
@property (weak, nonatomic) IBOutlet UILabel *success;
@property (weak, nonatomic) IBOutlet UILabel *error;

@property (weak, nonatomic) IBOutlet UILabel *studentName;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *instUrl;
@property (weak, nonatomic) IBOutlet UILabel *semestername;
@property (weak, nonatomic) IBOutlet UILabel *student;


@property (weak, nonatomic) IBOutlet UILabel *studentIdtext;
@property (weak, nonatomic) IBOutlet UILabel *sectiontxt;
@property (weak, nonatomic) IBOutlet UILabel *coursetxt;
@property (weak, nonatomic) IBOutlet UILabel *dateofbirthtxt;
@property (weak, nonatomic) IBOutlet UILabel *addresstxt;
@property (weak, nonatomic) IBOutlet UILabel *emailtxt;
@property (weak, nonatomic) IBOutlet UILabel *batchtxt;
@property (weak, nonatomic) IBOutlet UILabel *mobiletxt;
@property (weak, nonatomic) IBOutlet UILabel *aboutTxt;
@property (weak, nonatomic) IBOutlet UILabel *contactTxt;
@property (weak, nonatomic) IBOutlet UIButton *aboutBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;


@end
