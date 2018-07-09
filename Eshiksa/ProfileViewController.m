//
//  ProfileViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "ProfileViewController.h"
#import <Foundation/Foundation.h>
#import "Constant.h"
#import "BaseViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Base.h"
@interface ProfileViewController ()
{
    BOOL isSelected;
}

@end

@implementation ProfileViewController
@synthesize studentIdtext;
@synthesize groupnametxt;
@synthesize dateofbirthtxt;
@synthesize addresstxt;
@synthesize emailtxt;
@synthesize mobiletxt;
@synthesize aboutTxt;
@synthesize contactTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_downBtn setTitle:@"Contact" forState:UIControlStateNormal];
    [_downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      isSelected=YES;
    _contactView.hidden=YES;
    _aboutView.hidden=NO;
  
    self.profilepicImg.layer.cornerRadius = self.profilepicImg.frame.size.width / 2;
    self.profilepicImg.clipsToBounds = YES;
    self.profilepicImg.layer.borderWidth = 1.0f;
    self.profilepicImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.profileview.layer.cornerRadius = self.profilepicImg.frame.size.width / 2;
    self.profileview.clipsToBounds = YES;
    self.profileview.layer.borderWidth = 1.0f;
    self.profileview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //self.upBtn.layer.cornerRadius=6.0f;
    //self.downBtn.layer.cornerRadius=6.0f;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _downBtn.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(18.0/225.0) green:(132.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor, (id)[UIColor colorWithRed:(185.0/225.0) green:(156.0/225.0) blue:(231.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(202.0/225.0) green:(99.0/225.0) blue:(210.0/255.0)alpha:1.0].CGColor];
    
    [_downBtn.layer insertSublayer:gradient atIndex:0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_downBtn.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                         cornerRadii:CGSizeMake(6.0, 6.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _downBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _downBtn.layer.mask = maskLayer;
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_upBtn.bounds
                                                   byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(6.0, 6.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer1 = [CAShapeLayer layer];
    maskLayer1.frame = _upBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _upBtn.layer.mask = maskLayer1;
    
    [self getProfile];
    
}


-(void)getProfile{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in profile==%@",groupname);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"password"];
    NSLog(@"profile password ==%@",password);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"orgid"];
    NSLog(@"profile orgid ==%@",orgid);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"branchid"];
    NSLog(@"profile branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"cyear"];
    NSLog(@"profile cyear ==%@",cyear);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:profile]];
    
    //NSString *mainstr1=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/profile.php"];
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username": username,
       @"dbname":dbname,
       @"Branch_id":branchid,
       @"org_id":orgid,
       @"cyear":cyear,
       @"url": mainstr1,
       @"tag": @"user_detail",
       @"password": password };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response teacher profile data:%@",maindic);
            
            self.empid.text=[maindic objectForKey:@"empId"];
            self.groupname.text=[maindic objectForKey:@"groupname"];
            self.mobile.text=[maindic objectForKey:@"mobile"];
            self.email.text=[maindic objectForKey:@"email"];
            self.dob.text=[maindic objectForKey:@"dob"];
            self.address.text=[maindic objectForKey:@"address"];
            self.firstName.text=[maindic objectForKey:@"first_name"];
            self.lastName.text=[maindic objectForKey:@"last_name"];
    
            NSString *str4=[maindic objectForKey:@"pic_id"];
            
            NSString *tempimgstr=str4;
           [_profilepicImg sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                       placeholderImage:[UIImage imageNamed:@"default.png"]];
            
            self.teacherName.text = [NSString stringWithFormat: @"%@ %@", self.firstName.text,self.lastName.text];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:self.teacherName.text forKey:@"teachername"];
            [[NSUserDefaults standardUserDefaults] synchronize];
                NSLog(@"teachername ==%@",self.teacherName.text);
            
            [[NSUserDefaults standardUserDefaults] setObject:self.email.text forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"email ==%@",self.email.text);
            
            
            NSLog(@"Emp-id====%@ mobile num==%@",self.empid.text,self.mobile.text);
        }
    }];
}

- (IBAction)downBtnClicked:(id)sender {
    
    if (isSelected==YES) {
       [_downBtn setTitle:@"About" forState:UIControlStateNormal];
       [_downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        isSelected=NO;
       _aboutView.hidden=YES;
       _contactView.hidden=NO;
       _upBtnLbl.text=@"Contact";
        
    }
    else{
        [_downBtn setTitle:@"Contact" forState:UIControlStateNormal];
        [_downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        isSelected=YES;
        _contactView.hidden=YES;
         _aboutView.hidden=NO;
        _upBtnLbl.text=@"About";
    }
    
}
- (IBAction)upBtnClicked:(id)sender {

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    
    studentIdtext.text = [@"STUDENT_ID" localize];
    dateofbirthtxt.text=[@"DOB" localize];
    addresstxt.text=[@"HOME_ADDRESS" localize];
    emailtxt.text=[@"HOME_EMAIL" localize];
    groupnametxt.text=[@"BATCH" localize];
    mobiletxt.text=[@"HOME_MOBILE" localize];
    aboutTxt.text=[@"ABOUT" localize];
    contactTxt.text=[@"CONTACT" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    studentIdtext.text = [@"STUDENT_ID" localize];
    dateofbirthtxt.text=[@"DOB" localize];
    addresstxt.text=[@"HOME_ADDRESS" localize];
    emailtxt.text=[@"HOME_EMAIL" localize];
    groupnametxt.text=[@"BATCH" localize];
    mobiletxt.text=[@"HOME_MOBILE" localize];
    aboutTxt.text=[@"ABOUT" localize];
    contactTxt.text=[@"CONTACT" localize];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
