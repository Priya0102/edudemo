
#import "SettingsViewController.h"
#import "NSBundle+Language.h"
#import "NSString+Language.h"
#import "Header.h"
#import "AppDelegate.h"


@interface SettingsViewController ()
{
    __weak IBOutlet UIButton *englishButton;
    __weak IBOutlet UIButton *hindiButton;
}
@end

@implementation SettingsViewController
@synthesize englishTxt;
@synthesize hindiTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.uiview.layer.masksToBounds=YES;
    self.uiview.layer.cornerRadius=6;
    
    [hindiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hindiButton setTitle:[@"hindi" localize] forState:UIControlStateNormal];
    [hindiButton addTarget:self action:@selector(hindiButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [englishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [englishButton setTitle:[@"english" localize] forState:UIControlStateNormal];
    [englishButton addTarget:self action:@selector(englishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    
}
-(void)changeLanguage:(NSNotification*)notification
{
    [englishButton setTitle:[@"english" localize] forState:UIControlStateNormal];
    [hindiButton setTitle:[@"hindi" localize] forState:UIControlStateNormal];
}



- (void)hindiButtonAction{
    
   
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Are you sure,you want to change your language?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes,Please"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alertView dismissViewControllerAnimated:YES completion:nil];
                        
    [hindiButton setImage:[UIImage imageNamed:@"clicked64.png"] forState:UIControlStateNormal];
    [englishButton setImage:[UIImage imageNamed:@"unclicked64.png"] forState:UIControlStateNormal];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@[@"hi", @"en"] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSBundle *langBundle = [[NSBundle alloc]init];
    [langBundle setLanguage:@"hi"];
    [[NSUserDefaults standardUserDefaults]setObject:@"hi" forKey:@"selectedLanguage"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationName" object:nil];
    
                              }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No,thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   NSLog(@"you pressed No,thanks button");
                                   
                               }];
    
    [alertView addAction:ok];
    [alertView addAction:noButton];
  [self presentViewController:alertView animated:YES completion:nil];
    

    
}


- (void)englishButtonAction{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Are you sure,you want to change your language?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes,Please"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alertView dismissViewControllerAnimated:YES completion:nil];
                        
    
    [englishButton setImage:[UIImage imageNamed:@"clicked64.png"] forState:UIControlStateNormal];
    [hindiButton setImage:[UIImage imageNamed:@"unclicked64.png"] forState:UIControlStateNormal];
    
    [[NSUserDefaults standardUserDefaults]setObject:@[@"en", @"hi"] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSBundle *langBundle = [[NSBundle alloc]init];
    [langBundle setLanguage:@"en"];
    [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"selectedLanguage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationName" object:nil];
     }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No,thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   NSLog(@"you pressed No,thanks button");
                                   
                               }];
    
    [alertView addAction:ok];
    [alertView addAction:noButton];
    [self presentViewController:alertView animated:YES completion:nil];

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    
    englishTxt.text = [@"LANG_EN" localize];
    hindiTxt.text=[@"LANG_HI" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage2:) name:@"notificationName" object:nil];
}

-(void)changeLanguage2:(NSNotification*)notification
{
    englishTxt.text = [@"LANG_EN" localize];
    hindiTxt.text=[@"LANG_HI" localize];
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"SETTINGS" localize];
}


@end
