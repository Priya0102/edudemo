//
//  TeacherViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttendanceViewController.h"
@interface TeacherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UIButton *galleryBtn;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImg;
@property (weak, nonatomic) IBOutlet UIButton *timetableBtn;
@property (weak, nonatomic) IBOutlet UIImageView *timetableImg;
@property (weak, nonatomic) IBOutlet UIButton *circularBtn;
@property (weak, nonatomic) IBOutlet UIImageView *circularImg;
@property (weak, nonatomic) IBOutlet UIButton *attendanceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *attendanceImg;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIImageView *settingImg;

@property (weak, nonatomic) IBOutlet UILabel *profiletxt;
@property (weak, nonatomic) IBOutlet UILabel *circulartext;
@property (weak, nonatomic) IBOutlet UILabel *gallerytxt;
@property (weak, nonatomic) IBOutlet UILabel *arrendancetxt;
@property (weak, nonatomic) IBOutlet UILabel *timetabletxt;
@property (weak, nonatomic) IBOutlet UILabel *settingstxt;
@property (weak, nonatomic) IBOutlet UILabel *poweredBy;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*user;

@end
