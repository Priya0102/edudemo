//
//  HrViewController.m
//  Eshiksa


#import "HrViewController.h"
#import "BaseViewController.h"
@interface HrViewController ()

@end

@implementation HrViewController
@synthesize requestLbl;
@synthesize viewReqLbl;
@synthesize salaryStrucLbl;
@synthesize reqLbl;
@synthesize myReportLbl;
@synthesize poweredLbl;


- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    requestLbl.text = [@"LEAVES_REQUEST_LEAVE" localize];
    viewReqLbl.text=[@"REQUISITIONS_LIST" localize];
    salaryStrucLbl.text = [@"SALARY_STRUCTURE" localize];
    reqLbl.text=[@"REQUISITIONS" localize];
    myReportLbl.text=[@"MY_REPORT" localize];
    poweredLbl.text=[@"POWERED_BY" localize];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)changeLanguage:(NSNotification*)notification
{
    requestLbl.text = [@"LEAVES_REQUEST_LEAVE" localize];
    viewReqLbl.text=[@"REQUISITIONS_LIST" localize];
    salaryStrucLbl.text = [@"SALARY_STRUCTURE" localize];
    reqLbl.text=[@"REQUISITIONS" localize];
    myReportLbl.text=[@"MY_REPORT" localize];
    poweredLbl.text=[@"POWERED_BY" localize];
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
