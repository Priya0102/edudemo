
#import "StudentLeaveViewController.h"
#import "BaseViewController.h"

@interface StudentLeaveViewController ()

@end

@implementation StudentLeaveViewController
@synthesize applyLeaveTxt;
@synthesize requestedLeaveTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    applyLeaveTxt.text = [@"APPLY_LEAVE" localize];
    requestedLeaveTxt.text=[@"LEAVES_REQUESTED_LEAVES" localize];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    applyLeaveTxt.text = [@"APPLY_LEAVE" localize];
    requestedLeaveTxt.text=[@"LEAVES_REQUESTED_LEAVES" localize];
}

- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"STUDENT_LEAVE" localize];
}
@end
