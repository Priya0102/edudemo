//
//  RequisitionViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import "RequisitionViewController.h"
#import "NIDropDown.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#import "Base.h"
#import "BaseViewController.h"
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@interface RequisitionViewController ()

@end

@implementation RequisitionViewController
@synthesize registerReqLbl;
@synthesize reqTitleLbl;
@synthesize reqTypeLbl;
@synthesize investmentLbl;
@synthesize reqDetailsLbl;
@synthesize registerReqBtnLbl;
@synthesize poweredByLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    requisitionBtnSelect.layer.borderWidth = 1;
    requisitionBtnSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    requisitionBtnSelect.layer.cornerRadius = 5;
    
    self.reisterReqBtn.layer.masksToBounds=YES;
    self.reisterReqBtn.layer.cornerRadius=8;
    
    [_reqTxtView setDelegate:self];
}
-(IBAction)requisitionTypeBtn:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"General Requisition",@"Leave Requisition",@"Loan Requisition",@"Investments Requisition",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown1 == nil) {
        CGFloat f = 80;
        dropDown1 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown1.delegate = self;
    }
    else {
        [dropDown1 hideDropDown:sender];
        [self rel];
    }
    
}
-(void)rel{

}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

- (IBAction)registerRequisitionBtnClicked:(id)sender {
    
    if(_requisitionTitle.text.length!=0 && _requisitionType.text.length!=0 && _investmentAmt.text.length!=0 && _requisitionDetails.text.length!=0){
     [self reisterRequisitionBtnCalled];
    }
    
    else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Please enter all details first" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [alertView addAction:ok];
        self.requisitionTitle.text=@"";
        [self presentViewController:alertView animated:YES completion:nil];
    }
}
-(void)reisterRequisitionBtnCalled{
    
    
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
  
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:empRequisition]];
    
       NSDictionary *parameterDict = @{
                                        @"groupname":groupname,
                                           @"username":username,
                                           @"instUrl":instUrl,
                                           @"dbname":dbname,
                                           @"Branch_id":branchid,
                                           @"org_id":orgid,
                                           @"cyear":cyear,
                                           @"url":mainstr1,
                                           @"tag": @"emprequisition",
                                           @"password":password,
                                           @"reqTitle":self.requisitionTitle.text,
                                           @"reqType": self.requisitionType.text,
                                           @"reqDetails":self.reqTxtView.text };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
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
                    self.requisitionTitle.text=@"";
                    self.reqTxtView.text=@"";
                    self.requisitionType.text=@"";
                    self.investmentAmt.text=@"";

                    
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    registerReqLbl.text = [@"REGISTER_A_REQUISITIONS" localize];
    reqTitleLbl.text=[@"REQUISITION_TITLE" localize];
    reqTypeLbl.text = [@"REQUISITION_TYPE" localize];
    investmentLbl.text=[@"INVESTMENT_AMOUNT" localize];
    reqDetailsLbl.text = [@"REQUISITION_DETAILS" localize];
    registerReqBtnLbl.text=[@"REGISTER_REQUISITIONS" localize];
    poweredByLbl.text=[@"POWERED_BY" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    registerReqLbl.text = [@"REGISTER_A_REQUISITIONS" localize];
    reqTitleLbl.text=[@"REQUISITION_TITLE" localize];
    reqTypeLbl.text = [@"REQUISITION_TYPE" localize];
    investmentLbl.text=[@"INVESTMENT_AMOUNT" localize];
    reqDetailsLbl.text = [@"REQUISITION_DETAILS" localize];
    registerReqBtnLbl.text=[@"REGISTER_REQUISITIONS" localize];
    poweredByLbl.text=[@"POWERED_BY" localize];
}

@end
