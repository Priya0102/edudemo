//
//  GatepassViewController.m
//  Eshiksa
///Users/punit/Desktop/Eshiksa/Eshiksa/Base.lproj/Main3.storyboard
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//
#import "BaseViewController.h"
#import "GatepassViewController.h"
#import "Constant.h"
#import "RzTextField.h"

#import "Base.h"
@interface GatepassViewController ()

@end

@implementation GatepassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.submitBtn.layer.masksToBounds=YES;
    self.submitBtn.layer.cornerRadius=8;
   
    [fromDateTxtField setDelegate:self];
    [toDateTxtField setDelegate:self];
    [fromTimeTxtField setDelegate:self];
    [toTimeTxtField setDelegate:self];
    
    [self.contactTextField setDelegate:self];
    [self.requestTextFiled setDelegate:self];
    
    [fromDateTxtField setDateField:YES];
    [toDateTxtField setDateField:YES];
    [fromTimeTxtField setTimeField:YES];
    [toTimeTxtField setTimeField:YES];
    
    //[self setUpTextFieldDatePicker];
}
-(void)ShowPicker {
    
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

//Needed to prevent keyboard from opening
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (IBAction)submitBtnClicked:(id)sender {

     [self submitGatepass];
}

-(void)submitGatepass{
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
    
    
    //NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/leave.php"];
    
    NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:leave]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname": dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":str,
                                    @"tag": @"gatepass_request",
                                    @"password":password,
                                    @"userId":userId,
                                    @"from":fromDateTxtField.text,
                                    @"to": toDateTxtField.text,
                                    @"reason":self.requestTextFiled.text,
                                    @"contact":self.contactTextField.text,
                                    
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
                self.requestTextFiled.text=@"";
                fromDateTxtField.text=@"";
                toDateTxtField.text=@"";
                self.contactTextField.text=@"";
                
                
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
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"GATEPASS" localize];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    _submitLbl.text = [@"SUBMIT" localize];
    _contactLbl.text = [@"CONTACT" localize];
  _requestLbl.text = [@"REQUEST_GATEPASS" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    _submitLbl.text = [@"SUBMIT" localize];
    _contactLbl.text = [@"CONTACT" localize];
    _requestLbl.text = [@"REQUEST_GATEPASS" localize];
   
    
}
//-(void)setUpTextFieldDatePicker
//{
//    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
//    datePicker.datePickerMode = UIDatePickerModeTime;
//    [datePicker setDate:[NSDate date]];
//    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
//    [fromTimeTxtField setInputView:datePicker];
//}
//
//-(void)updateTextField:(id)sender
//{
//    UIDatePicker *picker = (UIDatePicker*)fromTimeTxtField.inputView;
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
//    NSString *dateString = [outputFormatter stringFromDate:picker.date];
//    
//    [fromTimeTxtField.text = [NSString stringWithFormat:@"%@",dateString];
//}
@end
