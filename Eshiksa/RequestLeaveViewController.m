//
//  RequestLeaveViewController.m
//  Eshiksa

#import "RequestLeaveViewController.h"
#import "Constant.h"
#import "Base.h"
#import "BaseViewController.h"
@interface RequestLeaveViewController ()

@end

@implementation RequestLeaveViewController
@synthesize leaveLbl;
@synthesize reasonLbl;
@synthesize fromDateLbl;
@synthesize toDatelbl;
@synthesize reqLbl;
@synthesize poweredBy;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.requestLeaveBtn.layer.masksToBounds=YES;
    self.requestLeaveBtn.layer.cornerRadius=8;

    [_reasontextview setDelegate:self];
    [fromDateTxtField setDelegate:self];
    [toDateTxtField setDelegate:self];
    
    [fromDateTxtField setDateField:YES];
    [toDateTxtField setDateField:YES];
    
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
-(void)requestLeave{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in requisition==%@",groupname);
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"requisition branchid ==%@",branchid);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"requisition orgid ==%@",orgid);
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"requisition cyear ==%@",cyear);
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"requisition password ==%@",password);
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"userId"];
    NSLog(@"profile userId ==%@",userId);
    
    NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:leave]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id": orgid,
                                    @"cyear": cyear,
                                    @"url":str,
                                    @"tag": @"leave_request",
                                    @"password": password,
                                    @"userId":userId,
                                    @"from":fromDateTxtField,
                                    @"to":toDateTxtField,
                                    @"reason":self.reasontextview
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _successMsg=[maindic objectForKey:@"success_msg"];
            
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
                toDateTxtField.text=@"";
                fromDateTxtField.text=@"";
                self.reasontextview.text=@"";
           
                
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Osps!" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
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
- (IBAction)requestLeaveBtnClicked:(id)sender {
    
    NSLog(@"REQUEST BTN CLICKED.......");
    [self requestLeave];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
  
    leaveLbl.text = [@"LEAVES" localize];
    reasonLbl.text=[@"REASON" localize];
    fromDateLbl.text = [@"FROM_DATE" localize];
    toDatelbl.text=[@"TO_DATE" localize];
    reqLbl.text=[@"REQUEST_LEAVE" localize];
    poweredBy.text=[@"POWERED_BY" localize];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)changeLanguage:(NSNotification*)notification
{
    leaveLbl.text = [@"LEAVES" localize];
    reasonLbl.text=[@"REASON" localize];
    fromDateLbl.text = [@"FROM_DATE" localize];
    toDatelbl.text=[@"TO_DATE" localize];
    reqLbl.text=[@"REQUEST_LEAVE" localize];
    poweredBy.text=[@"POWERED_BY" localize];
    
}
@end
