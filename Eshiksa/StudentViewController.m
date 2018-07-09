//
//  StudentViewController.m
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.

#import "StudentViewController.h"
#import "BaseViewController.h"
#import "Constant.h"
#import "Base.h"
@interface StudentViewController ()

@end

@implementation StudentViewController
@synthesize profiletxt;
@synthesize circulartext;
@synthesize gallerytxt;
@synthesize payfeestxt;
@synthesize paidfeestxt;
@synthesize settingstxt;
@synthesize poweredBy;
- (void)viewDidLoad {
    [super viewDidLoad];
  
 self.profileBtn.layer.cornerRadius=6.0f;
 self.galleryBtn.layer.cornerRadius=6.0f;
 self.paidBtn.layer.cornerRadius=6.0f;
 self.circularBtn.layer.cornerRadius=6.0f;
 self.payfeeBtn.layer.cornerRadius=6.0f;
 self.settingBtn.layer.cornerRadius=6.0f;

   // [self pushNotificationParsing];
}
-(void)pushNotificationParsing{
    
    NSString *token_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"fcmToken"];
    NSLog(@"*****token_id ==%@",token_id);
    NSString *deviceidStr = [[NSUserDefaults standardUserDefaults]stringForKey:@"deviceToken"];
    NSLog(@"*****deviceId str ==%@",deviceidStr);
    NSString *username = [[NSUserDefaults standardUserDefaults]stringForKey:@"username"];
    NSLog(@"*****username ==%@",username);
    
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:push_notifications]];
    
    NSDictionary *parameterDict =@{
                                   @"tag":@"insert_token",
                                   @"token_id":token_id,
                                   @"device_id":deviceidStr,
                                   @"dbname":dbname,
                                   @"user_id":username
                                   };
    NSLog(@"*****parameter dic==%@",parameterDict);
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response :%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            
            if([self.success isEqualToString:@"1"])
            {
                NSLog(@"SUCCESS................");
                
            }
            else
            {
                NSLog(@"ERROR............");
            }
            
        }
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    profiletxt.text = [@"MY_PROFILE" localize];
    circulartext.text=[@"CIRCULAR" localize];
    payfeestxt.text = [@"PAY_FEES" localize];
    paidfeestxt.text=[@"PAID_FEES" localize];
    gallerytxt.text=[@"GALLERY" localize];
    settingstxt.text=[@"SETTINGS" localize];
    poweredBy.text=[@"POWERED_BY" localize];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    
}

-(void)changeLanguage:(NSNotification*)notification
{
    profiletxt.text = [@"MY_PROFILE" localize];
    circulartext.text=[@"CIRCULAR" localize];
    payfeestxt.text = [@"PAY_FEES" localize];
    paidfeestxt.text=[@"PAID_FEES" localize];
    gallerytxt.text=[@"GALLERY" localize];
    settingstxt.text=[@"SETTINGS" localize];
    poweredBy.text=[@"POWERED_BY" localize];
}


@end
