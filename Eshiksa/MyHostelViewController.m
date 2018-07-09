//
//  MyHostelViewController.m
//  Eshiksa
//
//  Created by Punit on 02/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "MyHostelViewController.h"
#import "MyRoom.h"
#import "MyRoomTableViewCell.h"
#import "Constant.h"
#import "RoomPartner.h"
#import "RoomPartnersTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
@interface MyHostelViewController ()

@end

@implementation MyHostelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
       [self.tableview setSeparatorColor:[UIColor clearColor]];
       [self.tableview2 setSeparatorColor:[UIColor clearColor]];
    
    _studentArr=[[NSMutableArray alloc]init];
    _studentNameArr=[[NSMutableArray alloc]init];
    _batchNameArr=[[NSMutableArray alloc]init];
    _courseNameArr=[[NSMutableArray alloc]init];
    _mobileNumArr=[[NSMutableArray alloc]init];
    
    
    _hostelArr=[[NSMutableArray alloc]init];
    _hostelNameArr=[[NSMutableArray alloc]init];
    _issueDateArr=[[NSMutableArray alloc]init];
    _roomNumArr=[[NSMutableArray alloc]init];
    _floorNumArr=[[NSMutableArray alloc]init];
    
    [self parsingRoomRequest];
    [self parsingHostelRoomRequest];
}
-(void)parsingRoomRequest
{
    
    [_studentArr removeAllObjects];
    [_studentNameArr removeAllObjects];
    [_batchNameArr removeAllObjects];
    [_courseNameArr removeAllObjects];
    [_mobileNumArr removeAllObjects];
    
    
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
                                    @"tag": @"my_hostel_partner"
                                    };
    NSLog(@"dictttt%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  remark  data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"partner_detail"];
            
            
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
                NSString *str1=[[temp objectForKey:@"student_fname"]description];
                NSString *str2=[[temp objectForKey:@"course_name"]description];
                NSString *str3=[[temp objectForKey:@"batch_name"]description];
                NSString *str4=[[temp objectForKey:@"mobile"]description];
                
                
                NSLog(@"student_fname=%@  course_name=%@ batch_name=%@ mobile=%@",str1,str2,str3,str4);
                
                
                MyRoom *k1=[[MyRoom alloc]init];
                k1.studentNameStr=str1;
                k1.courseNameStr=str2;
                k1.batchStr=str3;
                k1.mobileStr=str4;
                
                [_studentArr addObject:k1];
                
                [_tableview reloadData];
            }
            }
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    //[task resume];
    
    
}
-(void)parsingHostelRoomRequest
{
    
    [_hostelArr removeAllObjects];
    [_hostelNameArr removeAllObjects];
    [_issueDateArr removeAllObjects];
    [_roomNumArr removeAllObjects];
    [_floorNumArr removeAllObjects];
    
    
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
                                    @"tag": @"my_hostel"
                                    };
    NSLog(@"hostel dictttt%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  remark  data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"hostel_detail"];
            
            
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
                NSString *str1=[[temp objectForKey:@"issue_date"]description];
                NSString *str2=[[temp objectForKey:@"room_no"]description];
                NSString *str3=[[temp objectForKey:@"room_floor"]description];
                NSString *str4=[[temp objectForKey:@"hostel_name"]description];
                
                
                NSLog(@"issue_date=%@  room_no=%@ room_floor=%@ hostel_name=%@",str1,str2,str3,str4);
                
                
                RoomPartner *k1=[[RoomPartner alloc]init];
                k1.issueDateStr=str1;
                k1.roomNumStr=str2;
                k1.floorNumStr=str3;
                k1.hostelNameStr=str4;
                
                [_hostelArr addObject:k1];
                
                [_tableview2 reloadData];
            }
        }
        }
        [_tableview2 performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    //[task resume];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_tableview) {
        return 1;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableview) {
    return _studentArr.count;
    }
    return _hostelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==_tableview) {
    MyRoomTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MyRoom *ktemp=[_studentArr objectAtIndex:indexPath.row];
    
    cell.studentName.text=ktemp.studentNameStr;
    cell.batchName.text=ktemp.batchStr;
    cell.courseName.text=ktemp.courseNameStr;
    cell.mobile.text=ktemp.mobileStr;

    }
    else if (tableView==self.tableview2) {
        
    RoomPartnersTableViewCell *cell = [_tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RoomPartner *ktemp=[_hostelArr objectAtIndex:indexPath.row];
    
    cell.hostelName.text=ktemp.hostelNameStr;
    cell.issueDate.text=ktemp.issueDateStr;
    cell.roomNumber.text=ktemp.roomNumStr;
    cell.roomFloor.text=ktemp.floorNumStr;
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    _myRoomLbl.text = [@"MY_ROOM" localize];
    _roomPartnerLbl.text=[@"ROOM_PARTNERS" localize];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    _myRoomLbl.text = [@"MY_ROOM" localize];
    _roomPartnerLbl.text=[@"ROOM_PARTNERS" localize];
}

@end
