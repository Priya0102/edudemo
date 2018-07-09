
//  LoginViewController.m
//  Eshiksa

#import "LoginViewController.h"
#import "Constant.h"
#import "LoginUser.h"
#import "StudentViewController.h"
#import <Foundation/Foundation.h>
#import "TeacherViewController.h"
#import "Reachability.h"
#import "BaseViewController.h"
#import "Base.h"
#import "DBManager.h"
@interface LoginViewController ()
{
    NSString *mainstr;
}
@end

@implementation LoginViewController
@synthesize logintxt;
@synthesize forgotpasswordTxt;
@synthesize submitTxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:20.0/255.0 green:99.0/255.0 blue:250.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor=[UIColor lightGrayColor];
  self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.loginBtn.layer.masksToBounds=YES;
    self.loginBtn.layer.cornerRadius=8;
    
    self.uiview.layer.masksToBounds=YES;
    self.uiview.layer.cornerRadius=8;
    
    [self testInternetConnection];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = _loginBtn.bounds;
    gradient1.colors = @[(id)[UIColor colorWithRed:(49.0/225.0) green:(129.0/225.0) blue:(231.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(18.0/225.0) green:(132.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor];
    
    
    [_loginBtn.layer insertSublayer:gradient1 atIndex:0];
    

    _userArr=[[NSMutableArray alloc]init];
    
    _loginView.layer.masksToBounds=YES;

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _loginView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(18.0/225.0) green:(132.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor, (id)[UIColor colorWithRed:(185.0/225.0) green:(156.0/225.0) blue:(231.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(202.0/225.0) green:(99.0/225.0) blue:(210.0/255.0)alpha:1.0].CGColor];
    
    [_loginView.layer insertSublayer:gradient atIndex:0];

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_loginView.bounds
                                                   byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(8.0, 8.0)];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _loginView.bounds;
    maskLayer.path = maskPath.CGPath;
    _loginView.layer.mask = maskLayer;
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"No internet connection" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        
        
    }

    
}

- (IBAction)loginclicked:(id)sender {

    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(self.view.window.center.x,self.view.window.center.y, 40.0, 40.0);
        indicator.center=self.view.center;
    [self.view addSubview:indicator];
    
    
    indicator.tintColor=[UIColor redColor];
    indicator.backgroundColor=[UIColor blackColor];
    [indicator bringSubviewToFront:self.view];
    // [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
    [indicator startAnimating];
    if(self.username.text.length==0 && self.password.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Enter username and password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];
        
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    if(self.username.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"First Enter your Email-id" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];
        
        [indicator stopAnimating];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
    if(self.password.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"First Enter your Password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
    
    if(self.username.text.length>0 && self.password.text.length>0)
    {
        NSLog(@"hi");
        
        [self requestdata];
    }
    
}



-(void)requestdata{
  
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:auth]];
    
    
    NSDictionary *parameterDict = @{
                                    @"tag":@"login",
                                    @"Username":self.username.text,
                                    @"Password":self.password.text,
                                    @"dbname":dbname
                                    };
    
    [[NSUserDefaults standardUserDefaults] setObject:self.username.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    [Constant executequery:mainstr1 strpremeter:parameterDict
                 withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            
            NSLog(@"tag==%@& success=%@",_tag,_success);
            
   
            //for server db
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
            }];
            if ([error isEqual:@"1"]) {
            
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Entered credential is incorrect" preferredStyle:UIAlertControllerStyleAlert];
                
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
            
            NSDictionary *dic=[maindic objectForKey:@"user"];
            
            LoginUser *f=[[LoginUser alloc]init];
            
            f.gid=[dic objectForKey:@"gid"];
            f.firstname=[dic objectForKey:@"first_name"];
            f.lastname=[dic objectForKey:@"last_name"];
            f.mobile=[dic objectForKey:@"mobile"];
            f.email=[dic objectForKey:@"email"];
            f.schoolAdmissionNo=[dic objectForKey:@"school_admission_no"];
            f.groupName=[dic objectForKey:@"group_name"];
            f.password=[dic objectForKey:@"password"];
            f.orgType=[dic objectForKey:@"org_type"];
            f.stuemail=[dic objectForKey:@"stuemail"];
            f.branchid=[dic objectForKey:@"Branch_id"];
            f.userid=[dic objectForKey:@"userId"];
            f.orgId=[dic objectForKey:@"org_id"];
            f.cyear=[dic objectForKey:@"cyear"];
            f.futureFlag=[dic objectForKey:@"FutureFlag"];
            f.picId=[dic objectForKey:@"pic_id"];
            
                NSLog(@"branch Id:%@ group Name:%@ email id:%@ org type:%@",[dic objectForKey:@"Branch_id"],f.groupName,f.email,f.orgType);
            
            [[NSUserDefaults standardUserDefaults] setObject:f.groupName forKey:@"groupName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:f.password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:f.orgId forKey:@"orgid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:f.branchid forKey:@"branchid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:f.cyear forKey:@"cyear"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:f.userid forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
                
            [[NSUserDefaults standardUserDefaults] setObject:f.orgType forKey:@"orgType"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self navigatingFromLogin];
        }
        }
    }];
}
-(void)navigatingFromLogin{
  
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                                                       stringForKey:@"groupName"];
                               NSLog(@"group name==%@",groupname);
    
         if ([groupname isEqual:@"Student"])
         {
             StudentViewController *admin = [self.storyboard instantiateViewControllerWithIdentifier:@"ToStudent"];
             
             [self.navigationController pushViewController:admin animated:YES];
         }
    else
        //if ([groupname isEqual:@"Teacher"])
         {
             TeacherViewController *user = [self.storyboard instantiateViewControllerWithIdentifier:@"ToTeacher"];

             [self.navigationController pushViewController:user animated:YES];
        }
//        else  if ([groupname isEqual:@"null"]){
//
//            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Entered credential is incorrect" preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:@"OK"
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alertView dismissViewControllerAnimated:YES completion:nil];
//
//                                 }];
//
//            [alertView addAction:ok];
//            [self presentViewController:alertView animated:YES completion:nil];
//        }
}

- (void)testInternetConnection
{
    __weak typeof(self) weakSelf = self;
    
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    // NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachable.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            //Make sure user interaction on whatever control is enabled
        });
    };
    
    // Internet is not reachable
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"No Internet Connection" message:@"Please connect to the internet." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                 }];
            [alertView addAction:ok];
            [self presentViewController:alertView animated:YES completion:nil];
            //Make sure user interaction on whatever control is disabled
        });
    };
    
    [internetReachable startNotifier];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    logintxt.text = [@"LOGIN" localize];
    _username.placeholder = [@"ENTER_USERNAME" localize];
    _password.placeholder = [@"ENTER_PASSWORD" localize];
    forgotpasswordTxt.text = [@"FORGOT_PASSWORD" localize];
    submitTxt.text = [@"SUBMIT" localize];
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
   
[super viewDidAppear:(BOOL)animated];
[self.navigationController setNavigationBarHidden:YES animated:NO];

}

-(void)changeLanguage:(NSNotification*)notification
{
    logintxt.text = [@"LOGIN" localize];
    _username.placeholder = [@"ENTER_USERNAME" localize];
    _password.placeholder = [@"ENTER_PASSWORD" localize];
    forgotpasswordTxt.text = [@"FORGOT_PASSWORD" localize];
    submitTxt.text = [@"SUBMIT" localize];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [password resignFirstResponder];
    return YES;
}
@end
