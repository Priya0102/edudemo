//
//  TeacherSidebarViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherSidebarViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *teachername;
@property (strong, nonatomic) IBOutlet UILabel *gmail;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *firstname;
@property (strong, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *dashboardtxt;
@property (weak, nonatomic) IBOutlet UILabel *attandancetxt;
@property (weak, nonatomic) IBOutlet UILabel *settingtxt;
@property (weak, nonatomic) IBOutlet UILabel *timetabletxt;
@property (weak, nonatomic) IBOutlet UILabel *homeworktxt;
@property (weak, nonatomic) IBOutlet UILabel *librarytxt;
@property (weak, nonatomic) IBOutlet UILabel *hrtxt;
@property (weak, nonatomic) IBOutlet UILabel *logouttxt;

@end
