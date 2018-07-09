

#import "RequestedLeaveViewController.h"
#import "RequestedTableViewCell.h"
#import "RequestLeave.h"
#import "Constant.h"
#import "BaseViewController.h"
#import "Base.h"
@interface RequestedLeaveViewController ()

@end

@implementation RequestedLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fromDateArr=[[NSMutableArray alloc]init];
    _toDateArr=[[NSMutableArray alloc]init];
    _contactArr=[[NSMutableArray alloc]init];
    _reqLeaveArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingGatepass];
}

-(void)parsingGatepass{
    
    
    [_fromDateArr removeAllObjects];
    [_toDateArr removeAllObjects];
    [_contactArr removeAllObjects];
    [_reqLeaveArr removeAllObjects];
    
    
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
    NSLog(@"profile orgid ==%@",orgid);
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:leave]];

    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"cyear":cyear,
                                    @"tag":@"view_leave",
                                    @"org_id":orgid,
                                    @"url":urlstr
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  view_leave data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _studentId=[maindic objectForKey:@"studentId"];
            
            NSLog(@"Tag===%@",_tag);
            
            NSArray *gatepassarr=[maindic objectForKey:@"leave"];
            
            NSLog(@"gatepass:%@",gatepassarr);
            
            for(NSDictionary *temp in gatepassarr)
            {
                NSString *str1=[[temp objectForKey:@"from_date"]description];
                NSString *str2=[[temp objectForKey:@"to_date"]description];
                NSString *str3=[temp objectForKey:@"contact_no"];
                NSString *str4=[temp objectForKey:@"status"];
                
                
                NSLog(@"from_date=%@  to_date=%@ contact_no=%@ status=%@",str1,str2,str3,str4);
                
                
                RequestLeave *k1=[[RequestLeave alloc]init];
                k1.fromDatestr=str1;
                k1.toDateStr=str2;
                k1.contactStr=str3;
                k1.statusStr=str4;
                
                
                [_reqLeaveArr addObject:k1];
                
                [_tableview reloadData];
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
    return _reqLeaveArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RequestedTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RequestLeave *ktemp=[_reqLeaveArr objectAtIndex:indexPath.row];
    
    cell.fromDate.text=ktemp.fromDatestr;
    cell.toDate.text=ktemp.toDateStr;
    cell.contact.text=ktemp.contactStr;
    cell.status.text=ktemp.statusStr;
    
    if ([cell.status.text isEqualToString:@"1"]) {
        NSLog(@"Pending.......");
        cell.statusLblBtn.backgroundColor =[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        
        cell.status.text=@"P";
        cell.statusView.backgroundColor=[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        cell.imgview.image=[UIImage imageNamed:@"pending.png"];
    }
    if ([cell.status.text isEqualToString:@"2"]){
        NSLog(@"Approved.......");
        cell.statusLblBtn.backgroundColor =[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.status.text=@"A";
        cell.status.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.imgview.image=[UIImage imageNamed:@"approved.png"];
       
    }
    if ([cell.status.text isEqualToString:@"3"]){
        NSLog(@"Rejected.......");
        cell.statusLblBtn.backgroundColor =[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];        cell.status.text=@"R";
        cell.status.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];
        cell.imgview.image=[UIImage imageNamed:@"rejected.png"];
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
    self.navigationItem.title = [@"LEAVES_REQUEST_LEAVE" localize];
}


@end
