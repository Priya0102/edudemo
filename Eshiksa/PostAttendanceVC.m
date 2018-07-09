//
//  PostAttendanceVC.m
/*
 {"tag":"teachersubmitattendance","batch_id":"3006","username":"sharmaamita@gmail.com","course_id":"2226","dept_id":"729","date":"2018-06-23 07:50:52","Branch_id":"310",
 "students":[{"0":"239789","1":"1780","2":"Tunisha  Gupta","3":"","status":"Y","class_roll_no":"1780","first_name":"Tunisha  Gupta","isCheck":true,"last_name":"","student_id":"239789"}],"cyear":"2017-2018","dbname":"erpeshik_esh_slave_edemo_new","groupname":"Teacher","semester_id":"356","org_id":"1"}

//{"tag":"teachersubmitattendance","success":1,"error":0,"alert":"Attendance Taken Successfully"}
 (
 {
 0 = 31593;
 1 = 16215;
 2 = Aarna;
 3 = " Gupta";
 "class_roll_no" = 16215;
 "first_name" = Aarna;
 "last_name" = " Gupta";
 "student_id" = 31593;
 }
 );
 */

#import "PostAttendanceVC.h"
#import "BaseViewController.h"
#import "Base.h"
#import "Constant.h"
@interface PostAttendanceVC ()

@end

@implementation PostAttendanceVC

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
    

    
        NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:teachersclattendance]];
    
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
                                        @"date":date,
                                        @"students":_studentArrayList
                                        };
    
        NSLog(@"****PARAMETER DIC%@",parameterDict);
        
        [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
            NSLog(@"********data:%@",dbdata);
            
            if (dbdata!=nil) {
            NSError *error;
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"********json maindic data:%@",maindic);
           
                _tag=[maindic objectForKey:@"tag"];
                _success=[[maindic objectForKey:@"success"]stringValue];
                _error=[[maindic objectForKey:@"error"]stringValue];
                _successMsg=[maindic objectForKey:@"alert"];
         
                NSLog(@"tag==%@& success=%@  Alert msg=%@",_tag,_success,_successMsg);
                
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
