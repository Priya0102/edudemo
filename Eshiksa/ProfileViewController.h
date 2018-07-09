//
//  ProfileViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
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
@property (weak, nonatomic) IBOutlet UILabel *empid;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *groupname;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *picid;
@property (weak, nonatomic) IBOutlet UILabel *tag;
@property (weak, nonatomic) IBOutlet UILabel *success;
@property (weak, nonatomic) IBOutlet UILabel *error;

@property (weak, nonatomic) IBOutlet UILabel *studentIdtext;
@property (weak, nonatomic) IBOutlet UILabel *groupnametxt;
@property (weak, nonatomic) IBOutlet UILabel *dateofbirthtxt;
@property (weak, nonatomic) IBOutlet UILabel *addresstxt;
@property (weak, nonatomic) IBOutlet UILabel *emailtxt;
@property (weak, nonatomic) IBOutlet UILabel *mobiletxt;
@property (weak, nonatomic) IBOutlet UILabel *aboutTxt;
@property (weak, nonatomic) IBOutlet UILabel *contactTxt;
@end
