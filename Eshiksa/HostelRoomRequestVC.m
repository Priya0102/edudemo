//
//  HostelRoomRequestVC.m
//  Eshiksa
//
//  Created by Punit on 30/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "HostelRoomRequestVC.h"
#import "Constant.h"
#import "HostelRoomRequest.h"
#import "RoomRequestTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
@interface HostelRoomRequestVC ()

@end

@implementation HostelRoomRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _remarkArr=[[NSMutableArray alloc]init];
    _remarkRequestedStatusArr=[[NSMutableArray alloc]init];
    _remarkDateArr=[[NSMutableArray alloc]init];
    _remarkStatusArr=[[NSMutableArray alloc]init];
    _remarkGivenArr=[[NSMutableArray alloc]init];
    [self parsingRoomRequest];
    [self.tableview setSeparatorColor:[UIColor clearColor]];

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
    
    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/hostel.php";
    
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
                                    @"tag": @"room_request_list"
                                    };
    
    
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
                
                
                HostelRoomRequest *k1=[[HostelRoomRequest alloc]init];
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
    RoomRequestTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HostelRoomRequest *ktemp=[_remarkArr objectAtIndex:indexPath.row];
    
    cell.remarkDate.text=ktemp.remarkDateStr;
    cell.statusLbl.text=ktemp.statusLblStr;
    cell.requestedStatusLbl.text=ktemp.remarkRequestedStatusStr;
    cell.remark.text=ktemp.remarkStr;
    
    
    
    //ROOM REQUEST
    if ([cell.requestedStatusLbl.text isEqualToString:@"1"] && [cell.statusLbl.text isEqualToString:@"1"]){
        NSLog(@"Pending.......");
        cell.statusBtnClicked.backgroundColor = [UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        cell.btnStatusLbl.text=@"P";
        cell.btnStatusLbl.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        cell.statusImg.image=[UIImage imageNamed:@"pending.png"];
  
        
    }
    if ([cell.requestedStatusLbl.text isEqualToString:@"1"] && [cell.statusLbl.text isEqualToString:@"2"]){
        NSLog(@"Approved.......");
        cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.btnStatusLbl.text=@"A";
        cell.btnStatusLbl.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.statusImg.image=[UIImage imageNamed:@"approved.png"];
 
        
    }
    if ([cell.requestedStatusLbl.text isEqualToString:@"1"] && [cell.statusLbl.text isEqualToString:@"3"]){
        NSLog(@"Rejected.......");
        cell.statusBtnClicked.backgroundColor =[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
        cell.btnStatusLbl.text=@"R";
        cell.btnStatusLbl.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
        cell.statusImg.image=[UIImage imageNamed:@"rejected.png"];
   
        
    }
    
    return cell;
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


@end
