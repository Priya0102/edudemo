//
//  ForgotPassViewController.m
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "Constant.h"
#import "BaseViewController.h"
#import "Base.h"
@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController
@synthesize submitTxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.submitBtn.layer.masksToBounds=YES;
    self.submitBtn.layer.cornerRadius=8;
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = _submitBtn.bounds;
    gradient1.colors = @[(id)[UIColor colorWithRed:(49.0/225.0) green:(129.0/225.0) blue:(231.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(18.0/225.0) green:(132.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor];
    
    [_submitBtn.layer insertSublayer:gradient1 atIndex:0];
    
   // self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];

}
- (IBAction)submitBtnClicked:(UIButton *)sender {
    
     NSLog(@"submit btn clicked");
    
    if (_textField.text && _textField.text.length == 0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please enter username or email-id" preferredStyle:UIAlertControllerStyleAlert];
        
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
        [self forgotBtnDataParsing];
    }
    
    
}

-(void)forgotBtnDataParsing{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in ==%@",groupname);
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@" branchid ==%@",branchid);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@" orgid ==%@",orgid);
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@" cyear ==%@",cyear);

    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
   NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:change_pass]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname": dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":str,
                                    @"tag":@"forget_pass",
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
                self.textField.text=@"";
        
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
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
    
    _textField.placeholder = [@"HOME_EMAIL" localize];
    submitTxt.text = [@"SUBMIT" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(void)changeLanguage:(NSNotification*)notification
{
    _textField.placeholder = [@"HOME_EMAIL" localize];
    submitTxt.text = [@"SUBMIT" localize];
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"FORGOT_PASSWORD" localize];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
