//
//  LoginViewController.h
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface LoginViewController : UIViewController{
    
    IBOutlet UITextField *password;
    IBOutlet UITextField *username;
    IBOutlet UITextField *orgtype;
}
+(DBManager*)getSharedInstance;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *uiview;


@property (weak, nonatomic) IBOutlet UIButton *loginView;

@property (weak, nonatomic) IBOutlet UILabel *errorlbl;
@property (weak, nonatomic) IBOutlet UILabel *successLbl;
@property (weak, nonatomic) IBOutlet UILabel *tagLbl;


@property (nonatomic,strong) NSString *success,*email,*error,*tag,*user;
@property (retain,nonatomic) NSMutableArray *userArr;

-(void)requestdata;
@property (weak, nonatomic) IBOutlet UILabel *logintxt;
@property (weak, nonatomic) IBOutlet UILabel *forgotpasswordTxt;
@property (weak, nonatomic) IBOutlet UILabel *submitTxt;
@property (nonatomic, assign) BOOL myBool;
@end
