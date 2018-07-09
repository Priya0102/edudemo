#import "BaseViewController.h"
#import "ApplyLeaveViewController.h"
#import "Constant.h"
#import "RzTextField.h"
#import "Base.h"
@interface ApplyLeaveViewController ()

@end

@implementation ApplyLeaveViewController
@synthesize applyLeaveTxt;
@synthesize reasonTxt;
@synthesize fromDateTxt;
@synthesize toDateTxt;
@synthesize contactNumTxt;
@synthesize applyLeaveBtnTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [fromDateTxtField setDateField:YES];
    [toDateTxtField setDateField:YES];


    self.applyLeaveBtn.layer.masksToBounds=YES;
    self.applyLeaveBtn.layer.cornerRadius=8;
    
    [fromDateTxtField setDelegate:self];
    [toDateTxtField setDelegate:self];
    [self.contactTxtField setDelegate:self];

    //[self ShowPicker];
}

/*-(void)ShowPicker {
    
    CGFloat Height = self.view.frame.size.height;
    CGFloat Width = self.view.frame.size.width;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(PressDone)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    // txtFiled.inputView = numberToolbar;
    
    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height-200, Width, 200)];
    picker.backgroundColor = [UIColor greenColor];
    
    [picker addSubview:numberToolbar];
    [self.view addSubview:picker];
}

-(void)PressDone {
    
    NSLog(@"SELECTED DATE IS===");
    
}
*/
- (IBAction)applyLeaveBtnClicked:(id)sender {
    [self applyLeave];
}
-(void)applyLeave{
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
    
    
   // NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/leave.php"];
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
                                    @"password":password,
                                    @"userId":userId,
                                    @"from":fromDateTxtField.text,
                                    @"to":toDateTxtField.text,
                                    @"reason":self.reasonTxtField.text,
                                    @"contact":self.contactTxtField.text
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
            
            //  dispatch_async(dispatch_get_main_queue(), ^{
            
            //NSString *codeR = [[object objectForKey:@"success"] stringValue];
            // mysterious missing code
            //if ([coreR isEqualToString:@"200"])
            
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
                self.reasonTxtField.text=@"";
                self.contactTxtField.text=@"";
                
                
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
-(void)startDateSelected:(id)sender{
    
    NSLog(@"start date selected..");

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    

    applyLeaveTxt.text = [@"APPLY_LEAVE" localize];
    reasonTxt.text=[@"REASON" localize];
    fromDateTxt.text = [@"FROM_DATE" localize];
    toDateTxt.text=[@"TO_DATE" localize];
    contactNumTxt.text = [@"LEAVES_CONTACT_NO" localize];
    applyLeaveBtnTxt.text=[@"APPLY_LEAVE" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    applyLeaveTxt.text = [@"APPLY_LEAVE" localize];
    reasonTxt.text=[@"REASON" localize];
    fromDateTxt.text = [@"FROM_DATE" localize];
    toDateTxt.text=[@"TO_DATE" localize];
    contactNumTxt.text = [@"LEAVES_CONTACT_NO" localize];
    applyLeaveBtnTxt.text=[@"APPLY_LEAVE" localize];
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"APPLY_LEAVE" localize];
}
@end
