//
//  StudentSidebarViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.




#import "StudentSidebarViewController.h"
#import "Constant.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BaseViewController.h"
#import "Base.h"
@interface StudentSidebarViewController ()

@end

@implementation StudentSidebarViewController
@synthesize dashboardTxt;
@synthesize courseTxt;
@synthesize gatepassTxt;
@synthesize settingTxt;
@synthesize timetableTxt;
@synthesize homeworkTxt;
@synthesize transportTxt;
@synthesize leavesTxt;
@synthesize attendanceTxt;
@synthesize hostelTxt;
@synthesize libraryTxt;
@synthesize logoutTxt;



- (void)viewDidLoad {
    [super viewDidLoad];
   
     [self getProfile];
    
}
-(void)getProfile{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    
    //NSString *mainstr1=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/profile.php"];
    
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:profile]];
    
    
    NSDictionary *parameterDict =
    @{ @"groupname": groupname,
       @"username": username,
       @"dbname": dbname,
       @"Branch_id": branchid,
       @"org_id": orgid,
       @"cyear": cyear,
       @"url":mainstr1,
       @"tag": @"user_detail",
       @"password": password};
    
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response student profile data:%@",maindic);
        
            self.email.text=[maindic objectForKey:@"email"];
            self.firstname.text=[maindic objectForKey:@"first_name"];
            self.lastname.text=[maindic objectForKey:@"last_name"];
           
    
            NSString *str4=[maindic objectForKey:@"pic_id"];
            
            NSString *tempimgstr=str4;
            [_profileImg sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                             placeholderImage:[UIImage imageNamed:@"default.png"]];
            
            self.studentname.text = [NSString stringWithFormat: @"%@ %@", self.firstname.text,self.lastname.text];
            
            NSLog(@"studentname====%@ email num==%@",self.studentname.text,self.email.text);
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];

    dashboardTxt.text = [@"DASHBOARD" localize];
    courseTxt.text=[@"COURSE" localize];
    gatepassTxt.text = [@"GATEPASS" localize];
    settingTxt.text=[@"SETTINGS" localize];
    timetableTxt.text=[@"TIMETABLE" localize];
    homeworkTxt.text=[@"HOMEWORK_HOMEWORK" localize];
    transportTxt.text=[@"TRANSPORT_ROUTE" localize];
    leavesTxt.text=[@"LEAVES" localize];
    attendanceTxt.text=[@"ATTENDANCE" localize];
    hostelTxt.text=[@"HOSTELS" localize];
    libraryTxt.text=[@"LIBRARY" localize];
    logoutTxt.text=[@"LOGOUT" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    dashboardTxt.text = [@"DASHBOARD" localize];
    courseTxt.text=[@"COURSE" localize];
    gatepassTxt.text = [@"GATEPASS" localize];
    settingTxt.text=[@"SETTINGS" localize];
    timetableTxt.text=[@"TIMETABLE" localize];
    homeworkTxt.text=[@"HOMEWORK_HOMEWORK" localize];
    transportTxt.text=[@"TRANSPORT_ROUTE" localize];
    leavesTxt.text=[@"LEAVES" localize];
    attendanceTxt.text=[@"ATTENDANCE" localize];
    hostelTxt.text=[@"HOSTELS" localize];
    libraryTxt.text=[@"LIBRARY" localize];
    logoutTxt.text=[@"LOGOUT" localize];
}


@end
