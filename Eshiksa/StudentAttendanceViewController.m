

#import "StudentAttendanceViewController.h"
#import "Constant.h"
#import "StudentAttendance.h"
#import "BaseViewController.h"
#import "Base.h"
@interface StudentAttendanceViewController ()

@end

@implementation StudentAttendanceViewController
@synthesize totalLectureTxt;
@synthesize presentTxt;
@synthesize absentTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self requestdata];
}
-(void)requestdata{
    
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


    
   // NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/attendance.php"];
    
     NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:attendance]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":str,
                                    @"tag":@"attendance"
                                    };
    
   
    [Constant executequery:str strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            

            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            _rollnumber=[maindic objectForKey:@"rollno"];
            _attendance=[maindic objectForKey:@"attendance"];
            
            NSLog(@"tag==%@& success=%@",_tag,_success);
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
            }];
          
           // NSDictionary *tempdic=[maindic objectForKey:@"attendance"];
            
            //NSLog(@"######%@",tempdic);
       
            for (NSDictionary *tempdic in [maindic objectForKey:@"attendance"]) {
             
            
                NSString *str1=[tempdic objectForKey:@"total_lecture"];
                NSString *str2=[tempdic objectForKey:@"present_lecture"];
                NSString *str3=[tempdic objectForKey:@"absent_lecture"];
            
                NSLog(@"******total lecture=%@   present_lecture= %@  absent_lecture= %@",str1,str2,str3);
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        _totalLecturestr=str1;
                        _presentLecturestr=str2;
                        _absentLecturestr=str3;
                        
                        
                        _totalLecture.text=_totalLecturestr;
                        _presentLecture.text=_presentLecturestr;
                        _absentLecture.text=_absentLecturestr;
                    }];
            }
         }
    }];
}


-(void)requestdata1{
    
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
    

    
   // NSString *mainstr1=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/attendance.php"];
    
      NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:attendance]];

    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":mainstr1,
                                    @"tag":@"attendance"
                                    };
    
    
    
    [Constant executequery:mainstr1 strpremeter:[parameterDict valueForKey:@"parameterDict"] withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            _rollnumber=[maindic objectForKey:@"rollno"];
            
            NSLog(@"tag==%@& success=%@",_tag,_success);
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
            }];
            
            NSDictionary *dic=[maindic objectForKey:@"attendance"];
            NSLog(@"###dictionary###%@",dic);
            
             StudentAttendance *f=[[StudentAttendance alloc]init];
            
            f.totalLecture=[dic objectForKey:@"total_lecture"];
            f.presentLecture=[dic objectForKey:@"present_lecture"];
            f.absentLecture=[dic objectForKey:@"absent_lecture"];
            
            
              NSLog(@"absent lecture=%@",f.absentLecture);
            self.totalLecture.text=f.totalLecture;
            self.presentLecture.text=f.presentLecture;
            self.absentLecture.text=f.absentLecture;
      
            NSLog(@"total lecture=%@",self.totalLecture.text);
          
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    
    totalLectureTxt.text = [@"ATTENDANCE_SUBJECTWISE_DETAILS_TOTAL_LECTURE" localize];
    presentTxt.text=[@"ATTENDANCE_SUBJECTWISE_DETAILS_PRESENT_LECTURE" localize];
    absentTxt.text = [@"ATTENDANCE_SUBJECTWISE_DETAILS_ABSENT_LECTURE" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    totalLectureTxt.text = [@"ATTENDANCE_SUBJECTWISE_DETAILS_TOTAL_LECTURE" localize];
    presentTxt.text=[@"ATTENDANCE_SUBJECTWISE_DETAILS_PRESENT_LECTURE" localize];
    absentTxt.text = [@"ATTENDANCE_SUBJECTWISE_DETAILS_ABSENT_LECTURE" localize];
}

- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"ATTENDANCE" localize];
}
@end
