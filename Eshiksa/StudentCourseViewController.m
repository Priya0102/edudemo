

#import "StudentCourseViewController.h"
#import "Constant.h"
#import "Course.h"
#import "CourseTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
@interface StudentCourseViewController ()

@end

@implementation StudentCourseViewController
@synthesize subjects;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = _detailBtn.bounds;
    gradient1.colors = @[(id)[UIColor colorWithRed:(18.0/225.0) green:(132.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor, (id)[UIColor colorWithRed:(185.0/225.0) green:(156.0/225.0) blue:(231.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(202.0/225.0) green:(99.0/225.0) blue:(210.0/255.0)alpha:1.0].CGColor];
    
    [_detailBtn.layer insertSublayer:gradient1 atIndex:0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_detailBtn.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                         cornerRadii:CGSizeMake(8.0, 8.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _detailBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _detailBtn.layer.mask = maskLayer;
    
    UIBezierPath *maskPath5 = [UIBezierPath bezierPathWithRoundedRect:_subjectView.bounds
                                                    byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                          cornerRadii:CGSizeMake(8.0, 8.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer5 = [CAShapeLayer layer];
    maskLayer5.frame = _subjectView.bounds;
    maskLayer5.path = maskPath5.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _subjectView.layer.mask = maskLayer5;
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _subjectArr=[[NSMutableArray alloc]init];
    _subjectIdArr=[[NSMutableArray alloc]init];
    _subjectnameArr=[[NSMutableArray alloc]init];

    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingCourseData];
}
-(void)parsingCourseData{
    
    [_subjectArr removeAllObjects];
    [_subjectnameArr removeAllObjects];
    [_subjectIdArr removeAllObjects];
    
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
    
    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/subjectDetails.php";
    
      NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:newcircular]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag":@"subjects"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  subjects data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"subjects"];
            NSLog(@"subjects arr:%@",ciculararr);
            if(ciculararr.count==0)
            {
                _detailBtn.hidden=YES;
                _subjectView.hidden=YES;
                _backgroundImg.hidden=YES;
                
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"No data available" preferredStyle:UIAlertControllerStyleAlert];
                    
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
            
               for (NSDictionary *temp1 in ciculararr)
               {
              self.studentName.text=[temp1 objectForKey:@"student_name"];
              self.course.text=[temp1 objectForKey:@"course"];
              self.batch.text=[temp1 objectForKey:@"batch"];
              
              NSLog(@"student name=%@ course name=%@ batch name=%@",_studentName.text,_course.text,_batch.text);
              
            NSArray *subarr=[temp1 objectForKey:@"subject"];
             NSLog(@"****subject arr:%@",subarr);
              
            if(subarr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"No student data available" preferredStyle:UIAlertControllerStyleAlert];
                
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
            else {

    
                for(NSDictionary *temp in subarr)
                {
                    NSString *str1=[[temp objectForKey:@"subject_id"]description];
                    NSString *str2=[[temp objectForKey:@"subject_name"]description];
            
                    NSLog(@"subject_id=%@  subject_name=%@",str1,str2);
             
                    Course *k1=[[Course alloc]init];
                    k1.subjectIdStr=str1;
                    k1.subjectNameStr=str2;
          
                    [_subjectArr addObject:k1];
                    
                    [_tableview reloadData];
                }
            }
        }
    }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subjectArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Course *ktemp=[_subjectArr objectAtIndex:indexPath.row];
    
    cell.subjectId.text=ktemp.subjectIdStr;
    cell.subjectName.text=ktemp.subjectNameStr;
     NSLog(@"In cell for row***subject_id=%@  subject_name=%@",ktemp.subjectIdStr,  cell.subjectName.text);

    return cell;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    subjects.text = [@"HOMEWORK_SUBJECT" localize];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
   subjects.text = [@"HOMEWORK_SUBJECT" localize];
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"COURSE" localize];
}
@end
