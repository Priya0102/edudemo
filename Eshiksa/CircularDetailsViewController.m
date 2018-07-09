

#import "CircularDetailsViewController.h"
#import "Constant.h"
#import "CircularDetails.h"
#import "WebViewController.h"
#import "FileDownloader.h"
#import "WebViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BaseViewController.h"
#import "Base.h"
@interface CircularDetailsViewController ()
- (void)downloadingStarted;
- (void)downloadingFinishedFor:(NSURL *)url andData:(NSData *)data;
- (void)downloadingFailed:(NSURL *)url;

@end

@implementation CircularDetailsViewController
@synthesize attachmentTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    _attachmentBtn.layer.masksToBounds=YES;
    _attachmentBtn.layer.cornerRadius=8.0;
    
    self.titleCircular.text=self.titleStr;
    self.circularId.text=self.circularIdStr;
    
    NSLog(@"circular id==%@ title circular==%@",_circularIdStr,_titleStr);
    
    [self getCircularDetails];
}
-(void)getCircularDetails{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular details==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular details username ==%@",username);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular details branchid ==%@",branchid);

    
    //NSString *urlstr=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/newcircular.php"];
    
      NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:newcircular]];
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username": username,
       @"dbname":dbname,
       @"Branch_id":branchid,
       @"instUrl":instUrl,
       @"tag": @"circulardetail",
       @"circularId":self.circularId.text,
    };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response circular details data:%@",maindic);
            
            NSDictionary *dic=[maindic objectForKey:@"circulardetail"];
            CircularDetails *c=[[CircularDetails alloc]init];
            c.circularDetailStr=[dic objectForKey:@"discription"];
            c.circularIdStr=[dic objectForKey:@"title"];
            c.circularTitleStr=[dic objectForKey:@"id"];
            c.cirFlieStr=[dic objectForKey:@"cir_file"];
    
             _descriptionCircular.text=c.circularDetailStr;
            _cir_file.text=c.cirFlieStr;
            //if(c.cirFlieStr==(NSString *) [NSNull null])
//            if([c.cirFlieStr isEqualToString:@""])
//            {
//
//                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"No file to download" preferredStyle:UIAlertControllerStyleAlert];
//
//                UIAlertAction* ok = [UIAlertAction
//                                     actionWithTitle:@"OK"
//                                     style:UIAlertActionStyleDefault
//                                     handler:^(UIAlertAction * action)
//                                     {
//                                         [alertView dismissViewControllerAnimated:YES completion:nil];
//
//                                     }];
//
//                [alertView addAction:ok];
//
//                [self presentViewController:alertView animated:YES completion:nil];
//
//            }
            
            NSLog(@"circular details ==%@ circular file path ==%@",c.circularDetailStr,c.cirFlieStr);
            
            [[NSUserDefaults standardUserDefaults] setObject:c.cirFlieStr forKey:@"downloadurl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
    }];
    
}
- (IBAction)attachmentBtnClicked:(id)sender {

   NSLog(@"attachment Btn clicked");
    
    NSString *downloadurl = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"downloadurl"];
    NSLog(@"***downloadurl ==%@",downloadurl);
    
    if([downloadurl isEqualToString:@""])
    {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"No file to download" preferredStyle:UIAlertControllerStyleAlert];
        
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *downloadurl = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"downloadurl"];
    NSLog(@"***downloadurl ==%@",downloadurl);
    
    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showAttachment"]) {
        wvc.myURL=downloadurl;
    }
}
- (void)viewWillAppear:(BOOL)animated
    {
    [super awakeFromNib];
    
    attachmentTxt.text = [@"ATTACHMENT" localize];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}
-(void)changeLanguage:(NSNotification*)notification
{
    attachmentTxt.text = [@"ATTACHMENT" localize];
    
}
@end
