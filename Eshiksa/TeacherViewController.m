//
//  TeacherViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "TeacherViewController.h"
#import "BaseViewController.h"
#import "CollegeAttendanceVC.h"
#import "AttendanceViewController.h"
#import "Constant.h"
#import "Base.h"
@interface TeacherViewController ()

@end

@implementation TeacherViewController
@synthesize profiletxt;
@synthesize circulartext;
@synthesize gallerytxt;
@synthesize arrendancetxt;
@synthesize timetabletxt;
@synthesize settingstxt;
@synthesize poweredBy;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
    //    self.profileImg.layer.borderWidth = 1.0f;
    //    self.profileImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.profileBtn.layer.cornerRadius=6.0f;
    
    self.galleryImg.clipsToBounds = YES;
    self.galleryBtn.layer.cornerRadius=6.0f;
    

    self.timetableImg.clipsToBounds = YES;
    self.timetableBtn.layer.cornerRadius=6.0f;

    self.circularImg.clipsToBounds = YES;
    self.circularBtn.layer.cornerRadius=6.0f;
    
    self.attendanceImg.clipsToBounds = YES;
    self.attendanceBtn.layer.cornerRadius=6.0f;
    
    self.settingImg.clipsToBounds = YES;
    self.settingBtn.layer.cornerRadius=6.0f;
    
  // [self pushNotificationParsing];//uncomment when u r running in similuator
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    profiletxt.text = [@"MY_PROFILE" localize];
    circulartext.text=[@"CIRCULAR" localize];
    arrendancetxt.text = [@"ATTENDANCE" localize];
    timetabletxt.text=[@"TIMETABLE" localize];
    gallerytxt.text=[@"GALLERY" localize];
    settingstxt.text=[@"SETTINGS" localize];
    poweredBy.text=[@"POWERED_BY" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}
-(void)pushNotificationParsing{
    
    NSString *token_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"fcmToken"];
    NSLog(@"*****token_id ==%@",token_id);
    NSString *deviceidStr = [[NSUserDefaults standardUserDefaults]stringForKey:@"deviceToken"];
    NSLog(@"*****deviceId str ==%@",deviceidStr);
    NSString *username = [[NSUserDefaults standardUserDefaults]stringForKey:@"username"];
    NSLog(@"*****username ==%@",username);
    
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:push_notifications]];
    
    NSDictionary *parameterDict =@{
                                   @"tag":@"insert_token",
                                   @"token_id":token_id,
                                   @"device_id":deviceidStr,
                                   @"dbname":dbname,
                                   @"user_id":username
                                   };
    NSLog(@"*****parameter dic==%@",parameterDict);
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response :%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            
            if([self.success isEqualToString:@"1"])
            {
                NSLog(@"SUCCESS................");
                
            }
            else
            {
                NSLog(@"ERROR............");
            }
            
        }
    }];
    
    
}
-(void)changeLanguage:(NSNotification*)notification
{
    profiletxt.text = [@"MY_PROFILE" localize];
    circulartext.text=[@"CIRCULAR" localize];
    arrendancetxt.text = [@"ATTENDANCE" localize];
    timetabletxt.text=[@"TIMETABLE" localize];
    gallerytxt.text=[@"GALLERY" localize];
    settingstxt.text=[@"SETTINGS" localize];
    poweredBy.text=[@"POWERED_BY" localize];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
