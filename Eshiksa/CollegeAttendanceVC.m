//
//  CollegeAttendanceVC.m
//  Eshiksa


#import "CollegeAttendanceVC.h"
#import "BaseViewController.h"
#import "Base.h"
#import "Constant.h"
@interface CollegeAttendanceVC ()
{

    NSMutableArray *coursearr1,*coursearr2,*batcharr1,*batcharr2,*departmentarr1,*departmentarr2,*lecturearr1,*lecturearr2,*semesterarr1,*semesterarr2,*semesterarr3,*semesterarr4,*sectionarr1,*sectionarr2,*subarr1,*subarr2;
}
@end

@implementation CollegeAttendanceVC
@synthesize takeattendancetxt;
@synthesize coursetxt;
@synthesize basetxt;
@synthesize departmenttxt;
@synthesize semestertxt;
@synthesize sectiontxt;
@synthesize subjecttxt;
@synthesize datetxt;
@synthesize fetchStudentTxt;
@synthesize lectureTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
 self.fetchStudentBtn.layer.masksToBounds=YES;
 self.fetchStudentBtn.layer.cornerRadius=8;
    
    [dateTxtField setDelegate:self];
    [dateTxtField setDateField:YES];
    

    departmentBtnSelect.layer.borderWidth = 1;
    departmentBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    departmentBtnSelect.layer.cornerRadius = 5;
    
    lectureBtnSelect.layer.borderWidth = 1;
    lectureBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    lectureBtnSelect.layer.cornerRadius = 5;
    
    semesterBtnSelect.layer.borderWidth = 1;
    semesterBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    semesterBtnSelect.layer.cornerRadius = 5;
    
    courseBtnSelect.layer.borderWidth = 1;
    courseBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    courseBtnSelect.layer.cornerRadius = 5;
    
    batchBtnSelect.layer.borderWidth = 1;
    batchBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    batchBtnSelect.layer.cornerRadius = 5;
    
    sectionBtnSelect.layer.borderWidth = 1;
    sectionBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    sectionBtnSelect.layer.cornerRadius = 5;
    
    subjectBtnSelect.layer.borderWidth = 1;
    subjectBtnSelect.layer.borderColor = [[UIColor grayColor] CGColor];
    subjectBtnSelect.layer.cornerRadius = 5;
//    NSLog(@"date text field=%@",dateTxtField.text);
//
//    [[NSUserDefaults standardUserDefaults]setValue:dateTxtField.text forKey:@"date"];
//    NSLog(@"***date = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"date"]);
}
-(void)ShowPicker {
    
    CGFloat Height = self.view.frame.size.height;
    CGFloat Width = self.view.frame.size.width;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(PressDone)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
   
    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height-200, Width, 200)];
    picker.backgroundColor = [UIColor greenColor];
    
    [picker addSubview:numberToolbar];
    [self.view addSubview:picker];
}

-(void)PressDone {
    
    NSLog(@"SELECTED DATE IS===");
    
}
-(IBAction)courseBtnClicked:(id)sender {
  
      [_selectCourseBtnLbl setHidden:YES];
    NSString *groupname = [[NSUserDefaults standardUserDefaults]stringForKey:@"groupName"];
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
                                    @"instUrl":instUrl,
                                    @"tag": @"attendance"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            coursearr1= [[NSMutableArray alloc]init];
            coursearr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"teachercourse"];
            
            // NSUInteger count=sizeof(keyarr);
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"course_name"];
                NSString *str2=[temp objectForKey:@"course_id"];
                NSString *str3=[temp objectForKey:@"teacher_id"];
                
                if(count>i)
                {
                    [coursearr2 addObject:str2];
                    [coursearr1 addObject:str1];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        _courseNameLbl.text=_courseNameStr;
                        _courseIdLbl.text=_courseIdStr;
                        _teacherIdLbl.text=_teacherIdStr;
                        
                        NSLog(@"**_courseNameStr id==%@ _courseIdStr ==%@ _teacherIdStr==%@",str1,str2,str3);
    
                        
                    }];
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown1 == nil) {
                CGFloat f =80;
                dropDown1 = [[NIDropDown alloc]showDropDown:sender :&f :coursearr1 :arrImage :@"down"];
                
                dropDown1.delegate = self;
            }
            else {
                [dropDown1 hideDropDown:sender];
                [self rel];
            }
        }
        
    }];
}

-(IBAction)batchBtnClicked:(id)sender {
    
    [_selectBatchLbl setHidden:YES];
    
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
                                    @"tag": @"get_batch",
                                    @"course_id":courseid
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            batcharr1= [[NSMutableArray alloc]init];
            batcharr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"teacherbatch"];
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"batch_name"];
                NSString *str2=[temp objectForKey:@"batch_id"];
                NSString *str3=[temp objectForKey:@"teacher_id"];
                
                if(count>i)
                {
                    [batcharr1 addObject:str1];
                    [batcharr2 addObject:str2];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _batchNameLbl.text=_batchNameStr;
                        _batchIdLbl.text=_batchIdStr;
                        _teacherIdLbl.text=_teacherIdStr;
                        
                        NSLog(@"**_batchNameLbl==%@ _batchIdLbl name==%@ _teacherIdStr==%@",str1,str2,str3);
                        
                    }];
                    
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown2 == nil) {
                CGFloat f = 80;
                dropDown2 = [[NIDropDown alloc]showDropDown:sender :&f :batcharr1 :arrImage :@"down"];
                
                dropDown2.delegate = self;
            }
            else {
                [dropDown2 hideDropDown:sender];
                [self rel];
            }
        }
    }];
}
-(IBAction)departmentName:(id)sender {
    
    [_selectDepartmentBtnLbl setHidden:YES];
    
    
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
                                    @"tag": @"get_department",
                                    @"course_id":courseid,
                                    @"batch_id":batchid
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            departmentarr1= [[NSMutableArray alloc]init];
            departmentarr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"teacherdept"];
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"dept_id"];
                NSString *str2=[temp objectForKey:@"dept_name"];
                
                if(count>i)
                {
                    [departmentarr2 addObject:str1];
                    [departmentarr1 addObject:str2];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _departmentNameLbl.text=_departmentLblStr;
                        _departmentIdLbl.text=_departmentIdStr;
                        
                        
                        NSLog(@"**_departmentNameLbl==%@ _departmentIdLbl name==%@",str1,str2);
                        
                    }];
                    
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown3 == nil) {
                CGFloat f =80;
                dropDown3 = [[NIDropDown alloc]showDropDown:sender :&f :departmentarr1 :arrImage :@"down"];
                
                dropDown3.delegate = self;
            }
            else {
                [dropDown3 hideDropDown:sender];
                [self rel];
            }
        }
    }];
    
}
-(IBAction)lectureName:(id)sender {
    
    
    [_selectLectureBtnLbl setHidden:YES];
    
    
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
                                    @"tag": @"get_department",
                                    @"course_id":courseid,
                                    @"batch_id":batchid
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            lecturearr1= [[NSMutableArray alloc]init];
            lecturearr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"lecture"];
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"id"];
                NSString *str2=[temp objectForKey:@"timing_name"];
                
                if(count>i)
                {
                    [lecturearr2 addObject:str1];
                    [lecturearr1 addObject:str2];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _lectureNameLbl.text=_lectureLblStr;
                        _lectureIdLbl.text=_lectureIdStr;
                        
                        
                        NSLog(@"**_lectureLblStr==%@ _lectureIdStr name==%@",str1,str2);
                        
                    }];
                    
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown7 == nil) {
                CGFloat f =80;
                dropDown7 = [[NIDropDown alloc]showDropDown:sender :&f :lecturearr1 :arrImage :@"down"];
                
                dropDown7.delegate = self;
            }
            else {
                [dropDown7 hideDropDown:sender];
                [self rel];
            }
        }
    }];
    
}
-(IBAction)semesterName:(id)sender {
    
    [_selectSemesterBtnLbl setHidden:YES];
    
    NSString *departmentid = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"departmentId"];
    NSLog(@"departmentid in circular==%@",departmentid);
    
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
                                    @"tag": @"get_semester",
                                    @"course_id":courseid,
                                    @"batch_id":batchid,
                                    @"dept_id":departmentid
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            semesterarr1= [[NSMutableArray alloc]init];
            semesterarr2=[[NSMutableArray alloc]init];
            semesterarr3= [[NSMutableArray alloc]init];
            semesterarr4=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"teachersemester"];
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"section_id"];
                NSString *str2=[temp objectForKey:@"teacher_id"];
                NSString *str3=[temp objectForKey:@"session_id"];
                NSString *str4=[temp objectForKey:@"session_name"];
                
                if(count>i)
                {
                    [semesterarr1 addObject:str1];
                    [semesterarr2 addObject:str2];
                    [semesterarr3 addObject:str3];
                    [semesterarr4 addObject:str4];

                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _sectionIdLbl.text=_sectionIdStr;
                        _teacherIdLbl.text=_teacherIdStr;
                        _sessionIdLbl.text=_sessionIdStr;
                        _sessionnameLbl.text=_sessionNameStr;
            
                        NSLog(@"**section_id==%@ teacher_id ==%@ session_id=%@ session_name ==%@",str1,str2,str3,str4);
                        
                    }];
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown4 == nil) {
                CGFloat f = 80;
                dropDown4 = [[NIDropDown alloc]showDropDown:sender :&f :semesterarr4 :arrImage :@"down"];
                
                dropDown4.delegate = self;
            }
            else {
                [dropDown4 hideDropDown:sender];
                [self rel];
            }
        }
    }];
}
-(IBAction)sectionName:(id)sender {
    
    [_selectSectionLbl setHidden:YES];
    
    NSString *teacherId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"teacherId"];
    NSLog(@"teacherId in circular==%@",teacherId);
    
    NSString *departmentId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"departmentId"];
    NSLog(@"departmentId in circular==%@",departmentId);
    
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"sessionId"];
    NSLog(@"sessionId in circular==%@",sessionId);
    
    NSString *sectionId = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"sectionId"];
    NSLog(@"sectionId in circular==%@",sectionId);
    
    
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
                                    @"tag": @"attendance"
//                                    @"course_id":courseid,
//                                    @"batch_id":batchid,
//                                    @"dept_id":departmentId,
//                                    @"section_id":sectionId,
//                                    @"semester_id":sessionId,
//                                    @"teacher_id":teacherId
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            sectionarr1= [[NSMutableArray alloc]init];
            sectionarr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"sections"];
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"section_id"];
                NSString *str2=[temp objectForKey:@"section_name"];
                
                if(count>i)
                {
                    [sectionarr2 addObject:str1];
                    [sectionarr1 addObject:str2];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _sectionNameLbl.text=_sectionNameStr;
                        _sectionIdLbl.text=_sectionIdStr;
                        
                        
                        NSLog(@"**_sectionNameLbl==%@ _sectionIdLbl name==%@",str1,str2);
                        
                    }];
                    
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown5 == nil) {
                CGFloat f = 80;
                dropDown5 = [[NIDropDown alloc]showDropDown:sender :&f :sectionarr1 :arrImage :@"down"];
                
                dropDown5.delegate = self;
            }
            else {
                [dropDown5 hideDropDown:sender];
                [self rel];
            }
        }
    }];
    
}
-(IBAction)subjectName:(id)sender {
    
    [_selectSubLbl setHidden:YES];
    
    NSString *teacherId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"teacherId"];
    NSLog(@"teacherId in circular==%@",teacherId);
    
    NSString *departmentId = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"departmentId"];
    NSLog(@"departmentId in circular==%@",departmentId);
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"sessionId"];
    NSLog(@"sessionId in circular==%@",sessionId);
    
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
                                    @"tag": @"get_subject",
                                    @"course_id":courseid,
                                    @"batch_id":batchid,
                                    @"dept_id":departmentId,
//@"section_id":sectionid,
                                    @"semester_id":sessionId
                                    //@"teacher_id":teacherId
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            subarr1= [[NSMutableArray alloc]init];
            subarr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"teachersubject"];
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"subject_id"];
                NSString *str2=[temp objectForKey:@"name"];
                
                if(count>i)
                {
                    [subarr2 addObject:str1];
                    [subarr1 addObject:str2];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _subNameLbl.text=_subNameStr;
                        _subIdLbl.text=_subIdStr;
                        
                        
                        NSLog(@"**_subNameStr==%@ _subIdStr name==%@",str1,str2);
                        
                    }];
                    
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown6 == nil) {
                CGFloat f = 80;
                dropDown6 = [[NIDropDown alloc]showDropDown:sender :&f :subarr1 :arrImage :@"down"];
                
                dropDown6.delegate = self;
            }
            else {
                [dropDown6 hideDropDown:sender];
                [self rel];
            }
        }
    }];
    
}

-(void)rel{
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    
    [self rel];
    //selected course id get
    NSUInteger i = [coursearr1 indexOfObject:courseBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)i);
    NSLog(@"courseBtnSelect==%@",courseBtnSelect.titleLabel.text);
    NSString *courseId = coursearr2[i];
    
    [[NSUserDefaults standardUserDefaults]setValue:courseId forKey:@"courseId"];
    NSLog(@"***courseId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"courseId"]);
    
    //selected batch id get
    NSUInteger b = [batcharr1 indexOfObject:batchBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)b);
    NSLog(@"batchBtnSelect==%@",batchBtnSelect.titleLabel.text);
    NSString *batchId = batcharr2[b];
    
    [[NSUserDefaults standardUserDefaults]setValue:batchId forKey:@"batchId"];
    NSLog(@"***batchId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"batchId"]);
    
    //selected department id get
    NSUInteger d=[departmentarr1 indexOfObject:departmentBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)d);
    NSLog(@"DEPARTMENT btn select=%@",departmentBtnSelect.titleLabel.text);
    NSString *departmentId=departmentarr2[d];
  
    
    [[NSUserDefaults standardUserDefaults]setValue:departmentId forKey:@"departmentId"];
    NSLog(@"***departmentId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"departmentId"]);
    
    
    //selected lecture id get
    NSUInteger lec=[lecturearr1 indexOfObject:lectureBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)lec);
    NSLog(@"lecture btn select=%@",lectureBtnSelect.titleLabel.text);
    NSString *lectureId=lecturearr2[lec];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:lectureId forKey:@"lectureId"];
    NSLog(@"***lectureId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"lectureId"]);
    
    //selected semester id get
    NSUInteger sem=[semesterarr4 indexOfObject:semesterBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)sem);
    NSLog(@"semester btn select=%@",semesterBtnSelect.titleLabel.text);
    NSString *teacherId=semesterarr2[sem];
    [[NSUserDefaults standardUserDefaults]setValue:teacherId forKey:@"teacherId"];
    NSLog(@"***teacherId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"teacherId"]);
    
    NSString *sessionId=semesterarr3[sem];
    [[NSUserDefaults standardUserDefaults]setValue:sessionId forKey:@"sessionId"];
    NSLog(@"***sessionId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]);
    
    NSString *sectionId=semesterarr1[sem];
    [[NSUserDefaults standardUserDefaults]setValue:sectionId forKey:@"sectionId"];
    NSLog(@"***sectionId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sectionId"]);
    
    //Selected section id get
    NSUInteger s = [sectionarr1 indexOfObject:sectionBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)s);
    NSLog(@"sectionBtnSelect==%@",sectionBtnSelect.titleLabel.text);
//   NSString *sectionIdstr = sectionarr2[s];
//
//    NSLog(@"***sectionBtnSelect====%@",sectionBtnSelect.titleLabel);
//
//    [[NSUserDefaults standardUserDefaults]setValue:sectionId forKey:@"sectionId"];
//    NSLog(@"***sectionId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sectionId"]);
    
    NSUInteger sub = [subarr1 indexOfObject:subjectBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)sub);
    NSLog(@"sectionsubjectBtnSelectBtnSelect==%@",subjectBtnSelect.titleLabel.text);
    NSString *subId = subarr2[sub];
    
    [[NSUserDefaults standardUserDefaults]setValue:subId forKey:@"subId"];
    NSLog(@"***sub Id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"subId"]);
}

- (IBAction)fetchStudentBtnClicked:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setObject:dateTxtField.text forKey:@"date"];
    NSLog(@"***date field in college = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"date"]);
    
    if (dateTxtField==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select mandatory fields before going further" preferredStyle:UIAlertControllerStyleAlert];
        
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
    else{
        
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    takeattendancetxt.text = [@"TAKE_ATTENDANCE" localize];
    coursetxt.text=[@"SUBJECT_COURSE" localize];
    basetxt.text = [@"BATCH" localize];
    departmenttxt.text = [@"DEPARTMENT" localize];
    semestertxt.text = [@"SEMESTER" localize];
    sectiontxt.text=[@"SECTION" localize];
    subjecttxt.text=[@"SUBJECT" localize];
    datetxt.text=[@"DATE" localize];
    fetchStudentTxt.text=[@"FETCH_STUDENT" localize];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    takeattendancetxt.text = [@"TAKE_ATTENDANCE" localize];
    coursetxt.text=[@"SUBJECT_COURSE" localize];
    basetxt.text = [@"BATCH" localize];
    departmenttxt.text = [@"DEPARTMENT" localize];
    semestertxt.text = [@"SEMESTER" localize];
    sectiontxt.text=[@"SECTION" localize];
    subjecttxt.text=[@"SUBJECT" localize];
    datetxt.text=[@"DATE" localize];
    fetchStudentTxt.text=[@"FETCH_STUDENT" localize];
}
@end
