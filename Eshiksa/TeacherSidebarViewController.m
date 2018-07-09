//
//  TeacherSidebarViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "TeacherSidebarViewController.h"
#import "Constant.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Base.h"
#import "BaseViewController.h"
#import "CollegeAttendanceVC.h"
#import "AttendanceViewController.h"
@interface TeacherSidebarViewController ()

@end

@implementation TeacherSidebarViewController
@synthesize dashboardtxt;
@synthesize attandancetxt;
@synthesize settingtxt;
@synthesize timetabletxt;
@synthesize homeworktxt;
@synthesize librarytxt;
@synthesize hrtxt;
@synthesize logouttxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getProfile];
    
}
-(void)getProfile{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in profile==%@",groupname);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"profile password ==%@",password);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"profile orgid ==%@",orgid);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"profile branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"profile cyear ==%@",cyear);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
      NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:profile]];
    
   // NSString *mainstr1=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/profile.php"];
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username":username,
       @"dbname":dbname,
       @"Branch_id":branchid,
       @"org_id":orgid,
       @"cyear":cyear,
       @"url":mainstr1,
       @"tag": @"user_detail",
       @"password":password };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response teacher profile data:%@",maindic);
            
           
        
            self.gmail.text=[maindic objectForKey:@"email"];
        
            self.firstname.text=[maindic objectForKey:@"first_name"];
            self.lastname.text=[maindic objectForKey:@"last_name"];
         
            NSString *str4=[maindic objectForKey:@"pic_id"];
            
            NSString *tempimgstr=str4;
            [_profileImg sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                              placeholderImage:[UIImage imageNamed:@"default.png"]];
            
            self.teachername.text = [NSString stringWithFormat: @"%@ %@", self.firstname.text,self.lastname.text];
        
            NSLog(@"Email====%@ teachername==%@",self.gmail.text,self.teachername.text);
        }
    }];
}
- (IBAction)attendanceBtnClicked:(id)sender {
    [self navigatingFromLogin];
}
-(void)navigatingFromLogin{
    
    NSString *orgtype = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"orgType"];
    NSLog(@"orgtype==%@",orgtype);
    
    if ([orgtype isEqual:@"School"])
    {
        AttendanceViewController *admin = [self.storyboard instantiateViewControllerWithIdentifier:@"schoolAttendance"];
        
        [self.navigationController pushViewController:admin animated:YES];
    }
    else
    {
        CollegeAttendanceVC *user = [self.storyboard instantiateViewControllerWithIdentifier:@"collegeAttendance"];
        
        [self.navigationController pushViewController:user animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    dashboardtxt.text = [@"DASHBOARD" localize];
    attandancetxt.text=[@"ATTENDANCE" localize];
    settingtxt.text = [@"SETTINGS" localize];
    timetabletxt.text=[@"TIMETABLE" localize];
    homeworktxt.text=[@"HOMEWORK_HOMEWORK" localize];
    librarytxt.text=[@"LIBRARY" localize];
    hrtxt.text=[@"HR" localize];
    logouttxt.text=[@"LOGOUT" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    dashboardtxt.text = [@"DASHBOARD" localize];
    attandancetxt.text=[@"ATTENDANCE" localize];
    settingtxt.text=[@"SETTINGS" localize];
    timetabletxt.text=[@"TIMETABLE" localize];
    homeworktxt.text=[@"HOMEWORK_HOMEWORK" localize];
    librarytxt.text=[@"LIBRARY" localize];
    hrtxt.text=[@"HR" localize];
    logouttxt.text=[@"LOGOUT" localize];
}



@end
