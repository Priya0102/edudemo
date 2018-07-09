//
//  StudentSidebarViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentSidebarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *studentname;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *firstname;
@property (weak, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *dashboardTxt;
@property (weak, nonatomic) IBOutlet UILabel *attendanceTxt;
@property (weak, nonatomic) IBOutlet UILabel *courseTxt;
@property (weak, nonatomic) IBOutlet UILabel *settingTxt;
@property (weak, nonatomic) IBOutlet UILabel *timetableTxt;
@property (weak, nonatomic) IBOutlet UILabel *homeworkTxt;
@property (weak, nonatomic) IBOutlet UILabel *transportTxt;
@property (weak, nonatomic) IBOutlet UILabel *leavesTxt;
@property (weak, nonatomic) IBOutlet UILabel *gatepassTxt;
@property (weak, nonatomic) IBOutlet UILabel *hostelTxt;
@property (weak, nonatomic) IBOutlet UILabel *libraryTxt;

@property (weak, nonatomic) IBOutlet UILabel *logoutTxt;


@end
