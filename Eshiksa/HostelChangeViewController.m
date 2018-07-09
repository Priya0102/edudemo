//
//  HostelChangeViewController.m
//  Eshiksa
//
//  Created by Punit on 02/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "HostelChangeViewController.h"
#import "Constant.h"
#import "HostelChange.h"
#import "HostelChangeTableViewCell.h"
#import "HostelChangeListVC.h"
#import "BaseViewController.h"
#import "Base.h"
@interface HostelChangeViewController ()

@end

@implementation HostelChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [fromDateTxtField setDateField:YES];

       [self.tableview setSeparatorColor:[UIColor clearColor]];
    _remarkArr=[[NSMutableArray alloc]init];
    _remarkRequestedStatusArr=[[NSMutableArray alloc]init];
    _remarkDateArr=[[NSMutableArray alloc]init];
    _remarkStatusArr=[[NSMutableArray alloc]init];
    _remarkGivenArr=[[NSMutableArray alloc]init];
    
    self.requestBtn.layer.masksToBounds=YES;
    self.requestBtn.layer.cornerRadius=8;
    
    [self.remark setDelegate:self];
    [fromDateTxtField setDelegate:self];
    
  [self parsingRoomRequest];

}


- (IBAction)requestBtnClicked:(id)sender {
    
    [self requestBtnParsing];
}
-(void)requestBtnParsing{
    
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
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    

    
   // NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/hostel.php"];
    
      NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:hostel]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":str,
                                    @"tag": @"room_change_request",
                                    @"remark":self.remark.text,
                                    @"remark_date": fromDateTxtField.text,
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
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
                self.remark.text=@"";
                fromDateTxtField.text=@"";
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oops!" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
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
-(void)parsingRoomRequest
{
    
    [_remarkArr removeAllObjects];
    [_remarkDateArr removeAllObjects];
    [_remarkStatusArr removeAllObjects];
    [_remarkRequestedStatusArr removeAllObjects];
    [_remarkGivenArr removeAllObjects];
    
    
    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote1]];
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
    
   // NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/hostel.php";
    
      NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:hostel]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag": @"room_change_list"
                                    };
    
    NSLog(@"hostel change==%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  remark  data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"change_list"];
            
            
            NSLog(@"ciculararr:%@",ciculararr);
            if(ciculararr.count==0)
            {
                _noSchedule = [[UITextView alloc]initWithFrame:
                               CGRectMake(80, 200, 400, 300)];
                [_noSchedule setText:@"No data available.."];
                [_noSchedule setTextColor:[UIColor grayColor]];
                [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:13]];
                _noSchedule.delegate =self;
                [self.view addSubview:_noSchedule];
                
            }
            else{

            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"remark_date"]description];
                NSString *str2=[[temp objectForKey:@"status"]description];
                NSString *str3=[[temp objectForKey:@"requested_status"]description];
                NSString *str4=[[temp objectForKey:@"remark"]description];
                
                
                NSLog(@"remark_date=%@  status=%@ requested_status=%@ remark=%@",str1,str2,str3,str4);
                
                
                HostelChange *k1=[[HostelChange alloc]init];
                k1.remarkDateStr=str1;
                k1.statusLblStr=str2;
                k1.remarkRequestedStatusStr=str3;
                k1.remarkStr=str4;
                
                [_remarkArr addObject:k1];
                
                [_tableview reloadData];
            }
            }
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
  
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _remarkArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HostelChangeTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HostelChange *ktemp=[_remarkArr objectAtIndex:indexPath.row];
    
    cell.remarkDate.text=ktemp.remarkDateStr;
    cell.statusLbl.text=ktemp.statusLblStr;
    cell.requestedStatusLbl.text=ktemp.remarkRequestedStatusStr;
    cell.remark.text=ktemp.remarkStr;
    
    
    
    //CHANGE REQUEST
      if ([cell.requestedStatusLbl.text isEqualToString:@"2"] && [cell.statusLbl.text isEqualToString:@"1"]){
     NSLog(@"Pending.......");
     cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
     
     cell.btnStatusLbl.text=@"P";
     cell.btnStatusLbl.textColor=[UIColor whiteColor];
     cell.statusView.backgroundColor=[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
     cell.statusImg.image=[UIImage imageNamed:@"pending.png"];
        [self navigatingFromLogin];

     }
     if ([cell.requestedStatusLbl.text isEqualToString:@"2"] && [cell.statusLbl.text isEqualToString:@"2"]){
     NSLog(@"Approved.......");
     cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
     cell.btnStatusLbl.text=@"A";
     cell.btnStatusLbl.textColor=[UIColor whiteColor];
     cell.statusView.backgroundColor=[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
    cell.statusImg.image=[UIImage imageNamed:@"approved.png"];

     }
     if ([cell.requestedStatusLbl.text isEqualToString:@"2"] && [cell.statusLbl.text isEqualToString:@"3"]){
     NSLog(@"Rejected.......");
     cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
     cell.btnStatusLbl.text=@"R";
     cell.btnStatusLbl.textColor=[UIColor whiteColor];
     cell.statusView.backgroundColor=[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
     cell.statusImg.image=[UIImage imageNamed:@"rejected.png"];

     }
    return cell;
}
-(void)navigatingFromLogin{
    
    NSString *status = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"status"];
    
    NSLog(@"status name==%@",status);
    
    NSString *reqstatus = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"requestedstatus"];
    NSLog(@"reqstatus name==%@",reqstatus);
    
    if ([status isEqualToString:@"2"] && [reqstatus isEqualToString:@"1"])
    {
        HostelChangeListVC *admin = [self.storyboard instantiateViewControllerWithIdentifier:@"hostelChangeList"];
        
        [self.navigationController pushViewController:admin animated:NO];
 
        NSLog(@"room request list....");
    }
    
    else
   {
        NSLog(@"room request btn clicked....");
        HostelChangeViewController *user = [self.storyboard instantiateViewControllerWithIdentifier:@"hostelChange"];
        
        [self.navigationController pushViewController:user animated:NO];
   }
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"HOSTEL" localize];
}
-(void)viewWillAppear:(BOOL)animated{
    _hostelRemarkLbl.text = [@"ROOM_HOSTEL_REMARK" localize];
    _dateLbl.text=[@"ROOM_HOSTEL_DATE" localize];
    _requestLbl.text=[@"ROOM_SAVE" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
}

-(void)changeLanguage:(NSNotification*)notification
{
    _hostelRemarkLbl.text = [@"ROOM_HOSTEL_REMARK" localize];
    _dateLbl.text=[@"ROOM_HOSTEL_DATE" localize];
    _requestLbl.text=[@"ROOM_SAVE" localize];
}
@end
