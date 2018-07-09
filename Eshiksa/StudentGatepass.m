

#import "StudentGatepass.h"
#import "BaseViewController.h"
@interface StudentGatepass ()

@end

@implementation StudentGatepass
@synthesize requestTxt;
@synthesize viewReqTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    requestTxt.text = [@"REQUEST_GATEPASS" localize];
    viewReqTxt.text=[@"VIEW_REQUEST" localize];
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    requestTxt.text = [@"REQUEST_GATEPASS" localize];
    viewReqTxt.text=[@"VIEW_REQUEST" localize];
    
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

@end
