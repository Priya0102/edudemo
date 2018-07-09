                                                                //
//  GatepassViewRequest.m
//  Eshiksa
//
//  Created by Punit on 28/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GatepassViewRequest.h"
#import "GatepassTableViewCell.h"
#import "Constant.h"
#import "BaseViewController.h"
#import "Base.h"
@interface GatepassViewRequest ()

@end

@implementation GatepassViewRequest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _fromDateArr=[[NSMutableArray alloc]init];
    _toDateArr=[[NSMutableArray alloc]init];
    _createdDateArr=[[NSMutableArray alloc]init];
    _gatepassArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingGatepass];
}

-(void)parsingGatepass{
    
    
    [_fromDateArr removeAllObjects];
    [_toDateArr removeAllObjects];
    [_createdDateArr removeAllObjects];
    [_gatepassArr removeAllObjects];
    
    
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

    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:leave]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"cyear":cyear,
                                    @"tag":@"gatepass"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  gatepass data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _studentId=[maindic objectForKey:@"studentId"];
            
            NSLog(@"Tag===%@",_tag);
            
          
            NSArray *ciculararr=[maindic objectForKey:@"gatepass "];
            
            
            NSLog(@"gatepass:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no gatepass data." preferredStyle:UIAlertControllerStyleAlert];
                
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
            else {

            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"from_date"]description];
                NSString *str2=[[temp objectForKey:@"to_date"]description];
                NSString *str3=[temp objectForKey:@"created_date"];
                NSString *str4=[temp objectForKey:@"status"];
                
                NSLog(@"from_date=%@  to_date=%@ created_date=%@ status=%@",str1,str2,str3,str4);

            
                [_gatepassArr addObject:temp];
                NSLog(@"_gatepassArr ARRAYY%@",_gatepassArr);
            }
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
    return _gatepassArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GatepassTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
    NSMutableDictionary *ktemp=[_gatepassArr objectAtIndex:indexPath.row];
    cell.fromDate.text=[[ktemp objectForKey:@"from_date"]description];
    cell.toDate.text=[[ktemp objectForKey:@"to_date"]description];
    cell.createdDate.text=[ktemp objectForKey:@"created_date"];
    cell.status.text=[ktemp objectForKey:@"status"];
    
    if ([cell.status.text isEqualToString:@"1"]) {
        NSLog(@"Pending.......");
        cell.statusLblBtn.backgroundColor =[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        cell.status.text=@"P";
        cell.statusView.backgroundColor=[UIColor colorWithRed:(255.0/225.0) green:(180.0/225.0) blue:(30.0/255.0) alpha:1.0];
        cell.statusImg.image=[UIImage imageNamed:@"pending.png"];
    }
    if ([cell.status.text isEqualToString:@"2"]){
        NSLog(@"Approved.......");
        cell.statusLblBtn.backgroundColor =[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.status.text=@"A";
        cell.status.textColor=[UIColor whiteColor];
        cell.statusView.backgroundColor=[UIColor colorWithRed:(37.0/225.0) green:(102.0/225.0) blue:(48.0/255.0) alpha:1.0];
        cell.statusImg.image=[UIImage imageNamed:@"approved.png"];
        
    }
    if ([cell.status.text isEqualToString:@"3"]){
        NSLog(@"Rejected.......");
        cell.statusLblBtn.backgroundColor =[UIColor colorWithRed:(195.0/225.0) green:(52.0/225.0) blue:(29.0/255.0) alpha:1.0];        cell.status.text=@"R";
        cell.status.textColor=[UIColor whiteColor];
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
    self.navigationItem.title = [@"GATEPASS" localize];
}

@end
