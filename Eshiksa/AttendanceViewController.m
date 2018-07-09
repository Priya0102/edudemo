//
//  AttendanceViewController.m
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "AttendanceViewController.h"
#import "NIDropDown.h"
#import <QuartzCore/QuartzCore.h>
#import "BaseViewController.h"
#import "Base.h"
#import "Constant.h"

#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@interface AttendanceViewController ()

{
     NSMutableArray *coursearr1,*coursearr2,*batcharr1,*batcharr2,*sectionarr1,*sectionarr2,*subarr1,*subarr2;
}
@property (nonatomic, readonly) CGFloat offset;

@end

@implementation AttendanceViewController{
    
    float fadeAlpha;
   
}
@synthesize takeAttendancetxt;
@synthesize coursetxt;
@synthesize batchtxt;
@synthesize sectiontxt;
@synthesize subjecttxt;
@synthesize datetxt;
@synthesize fetchStudenttxt;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fetchStudentBtn.layer.masksToBounds=YES;
    self.fetchStudentBtn.layer.cornerRadius=8;
  
   
    [dateTxtField setDelegate:self];
    [dateTxtField setDateField:YES];
   // [dateTxtField setDateTimeField:YES];
  
//_isDateTimeField
      // keyarr1= [[NSMutableArray alloc]init];
   // [self.venueBtn addTarget:self action:@selector(venueBtnClicked:) forControlEvents:UIControlEventTouchDown];
    
    
    fadeAlpha = 0.5f;
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
    
    
    self.navigationItem.hidesBackButton = NO;
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
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
-(void)getCourseId{
    
    
}
-(IBAction)courseselectClicked:(id)sender {
    
    [_selectCourseBtnLbl setHidden:YES];
    
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
            
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"course_name"];
                NSString *str2=[temp objectForKey:@"course_id"];
                NSString *str3=[temp objectForKey:@"teacher_id"];
                
                if(count>i)
                {
                    [coursearr1 addObject:str1];
                    [coursearr2 addObject:str2];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        _courseNameLbl.text=_courseNameStr;
                        _courseIdLbl.text=_courseIdStr;
                        _teacherIdLbl.text=_teacherIdStr;
                        
                        NSLog(@"**_courseNameStr==%@ _courseIdStr name==%@ _teacherIdStr==%@",str1,str2,str3);
            
                    }];
                    
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown1 == nil) {
                CGFloat f = 100;
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

-(IBAction)batchName:(id)sender {
    
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
-(IBAction)sectionName:(id)sender {
    
    [_selectSectionLbl setHidden:YES];
    
    
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
                                    @"tag": @"get_subject",
                                    @"course_id":courseid,
                                    @"batch_id":batchid
                                    };
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            sectionarr1= [[NSMutableArray alloc]init];
            sectionarr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"section"];
            
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
            
            if(dropDown3 == nil) {
                CGFloat f = 120;
                dropDown3 = [[NIDropDown alloc]showDropDown:sender :&f :sectionarr1 :arrImage :@"down"];
                
                dropDown3.delegate = self;
            }
            else {
                [dropDown3 hideDropDown:sender];
                [self rel];
            }
        }
    }];
    
}
-(IBAction)subjectName:(id)sender {
    
    [_selectSubLbl setHidden:YES];
    
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
                                    @"tag": @"get_subject",
                                    @"course_id":courseid,
                                    @"batch_id":batchid
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
            
            if(dropDown4 == nil) {
                CGFloat f = 80;
                dropDown4 = [[NIDropDown alloc]showDropDown:sender :&f :subarr1 :arrImage :@"down"];
                
                dropDown4.delegate = self;
            }
            else {
                [dropDown4 hideDropDown:sender];
                [self rel];
            }
        }
    }];

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
    
    //selected section id get
    NSUInteger s = [sectionarr1 indexOfObject:sectionBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)s);
    NSLog(@"sectionBtnSelect==%@",sectionBtnSelect.titleLabel.text);
    NSString *sectionId = sectionarr2[s];

    [[NSUserDefaults standardUserDefaults]setValue:sectionId forKey:@"sectionId"];
    NSLog(@"***sectionId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sectionId"]);
    
    //selected sub id
    
    NSUInteger sub = [subarr1 indexOfObject:subjectBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)sub);
    NSLog(@"sectionsubjectBtnSelectBtnSelect==%@",subjectBtnSelect.titleLabel.text);
    NSString *subId = subarr2[sub];
    
    [[NSUserDefaults standardUserDefaults]setValue:subId forKey:@"subId"];
    NSLog(@"***sub Id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"subId"]);
    
}

-(void)rel{

}

- (IBAction)fetchStudentBtnClicked:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setObject:dateTxtField.text forKey:@"date"];
    NSLog(@"***date = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"date"]);
    
    if (dateTxtField==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select  fields before going further" preferredStyle:UIAlertControllerStyleAlert];
        
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
    if (dropDown2==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select  fields before going further" preferredStyle:UIAlertControllerStyleAlert];
        
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
    if (dropDown3==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select  fields before going further" preferredStyle:UIAlertControllerStyleAlert];
        
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
        //[self fetchStudents];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    takeAttendancetxt.text = [@"TAKE_ATTENDANCE" localize];
    coursetxt.text=[@"SUBJECT_COURSE" localize];
    batchtxt.text = [@"BATCH" localize];
    sectiontxt.text=[@"SECTION" localize];
    subjecttxt.text=[@"SUBJECT" localize];
    datetxt.text=[@"DATE" localize];
    fetchStudenttxt.text=[@"FETCH_STUDENT" localize];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    takeAttendancetxt.text = [@"TAKE_ATTENDANCE" localize];
    coursetxt.text=[@"SUBJECT_COURSE" localize];
    batchtxt.text = [@"BATCH" localize];
    sectiontxt.text=[@"SECTION" localize];
    subjecttxt.text=[@"SUBJECT" localize];
    datetxt.text=[@"DATE" localize];
    fetchStudenttxt.text=[@"FETCH_STUDENT" localize];
}
@end
