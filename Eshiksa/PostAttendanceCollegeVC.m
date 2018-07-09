//
//  PostAttendanceCollegeVC.m
//  Eshiksa
//
//  Created by Punit on 16/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import "PostAttendanceCollegeVC.h"
#import "BaseViewController.h"
#import "Base.h"
#import "Constant.h"
@interface PostAttendanceCollegeVC ()

@end

@implementation PostAttendanceCollegeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *absentCountStr = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"absentCount"];
    NSLog(@"absentCount ==%@",absentCountStr);
    
    NSString *totalCountStr = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"totalCount"];
    NSLog(@"totalCount ==%@",totalCountStr);
    
    NSString *presentCountStr = [[NSUserDefaults standardUserDefaults]
                                 stringForKey:@"presentCount"];
    NSLog(@"presentCountStr ==%@",presentCountStr);
    
    self.totalStudentCount.text=totalCountStr;
    self.totalAbsentCount.text=absentCountStr;
    self.totalPresentCount.text=presentCountStr;
    
    self.postAttendanceBtn.layer.masksToBounds=YES;
    self.postAttendanceBtn.layer.cornerRadius=8;
    
    
}
- (IBAction)postAttendanceBtnClicked:(id)sender {
    [self postBtnClicked];
}

-(void)postBtnClicked{
    
    
    NSString *subId = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"subId"];
    NSLog(@"subId in circular==%@",subId);
    
    NSString *sectionid = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"sectionId"];
    NSLog(@"sectionId in circular==%@",sectionid);
    
    NSString *batchid = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"batchId"];
    NSLog(@"batchid in circular==%@",batchid);
    
    NSString *courseid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"courseId"];
    NSLog(@"courseid in circular==%@",courseid);
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
    NSString *date = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"date"];
    NSLog(@"circular date ==%@",date);
    
    NSString *departmentId = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"departmentId"];
    NSLog(@"departmentId in circular==%@",departmentId);
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"sessionId"];
    NSLog(@"sessionId in circular==%@",sessionId);
    
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:teacherclgattendance]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag": @"teachersubmitattendance",
                                    @"course_id":courseid,
                                    @"batch_id":batchid,
                                    @"section_id":sectionid,
                                    @"subject_id":subId,
                                    @"dept_id":departmentId,
                                    @"semester_id":sessionId,
                                    @"date":date,
                                    @"students":_studentArrayList
                                    };
    
    NSLog(@"Parameter post button==%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _successMsg=[maindic objectForKey:@"alert"];
            
            NSLog(@"tag==%@& success=%@  success msg=%@",_tag,_success,_successMsg);
            
        
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];

                                     }];


                [alertView addAction:ok];

                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oops!" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    _totalStudentLbl.text = [@"TOTAL_STUDENTS" localize];
    _totalPresentStudentLbl.text=[@"PRESENT_STUDENTS" localize];
    _totalAbsentStudentLbl.text = [@"ABSENT_STUDENTS" localize];
    _postAttendanceLbl.text = [@"SAVE_ATTENDANCE" localize];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    _totalStudentLbl.text = [@"TOTAL_STUDENTS" localize];
    _totalPresentStudentLbl.text=[@"PRESENT_STUDENTS" localize];
    _totalAbsentStudentLbl.text = [@"ABSENT_STUDENTS" localize];
    _postAttendanceLbl.text = [@"SAVE_ATTENDANCE" localize];
}
@end
