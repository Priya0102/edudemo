//
//  LibraryMyLogViewController.m
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "LibraryMyLogViewController.h"
#import "LibraryMyLog.h"
#import "LibraryMyLogTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
#import "Constant.h"
@interface LibraryMyLogViewController ()

@end

@implementation LibraryMyLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableview setSeparatorColor:[UIColor clearColor]];
    
    _mylogArr=[[NSMutableArray alloc]init];
    _booknameArr=[[NSMutableArray alloc]init];
    _issuedDateArr=[[NSMutableArray alloc]init];
    _dueDateArr=[[NSMutableArray alloc]init];
    _fineAmtArr=[[NSMutableArray alloc]init];
    _statusArr=[[NSMutableArray alloc]init];
   
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingCircular];
}
-(void)parsingCircular
{
    
    [_mylogArr removeAllObjects];
    [_booknameArr removeAllObjects];
    [_issuedDateArr removeAllObjects];
    [_dueDateArr removeAllObjects];
    [_fineAmtArr removeAllObjects];
    [_statusArr removeAllObjects];
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);

    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:library]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"instUrl":instUrl,
                                    @"tag": @"student_log"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  lib_books data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"lib_logs"];
            
            
            NSLog(@"ciculararr:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no log data." preferredStyle:UIAlertControllerStyleAlert];
                
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
                    
                    NSString *str2=[[temp objectForKey:@"book_name"]description];
                    NSString *str3=[temp objectForKey:@"issued_date"];
                    NSString *str4=[temp objectForKey:@"due_date"];
                    NSString *str5=[[temp objectForKey:@"fine_amount"]description];
                    NSString *str6=[[temp objectForKey:@"status"]description];
                    
                    
                    NSLog(@"book_name=%@ issued_date=%@ due_date=%@ fine_amount=%@  status=%@",str2,str3,str4,str5,str6);
                    
                    
                    LibraryMyLog *k1=[[LibraryMyLog alloc]init];
                    
                    k1.booknameStr=str2;
                    k1.issuedDateStr=str3;
                    k1.dueDateStr=str4;
                    k1.fineAmtStr=str5;
                    k1.statusStr=str6;
                   
                    
                    [_mylogArr addObject:k1];
                    
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
    return _mylogArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryMyLogTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    LibraryMyLog *ktemp=[_mylogArr objectAtIndex:indexPath.row];
    
    cell.bookname.text=ktemp.booknameStr;
    cell.issuedDate.text=ktemp.issuedDateStr;
    cell.dueDate.text=ktemp.dueDateStr;
    cell.fineAmt.text=ktemp.fineAmtStr;
    cell.status.text=ktemp.statusStr;
    
    if ([cell.status.text isEqualToString:@"1"]) {
        NSLog(@"Approved.......");
        cell.statusLbl.text=@"Approved";
        cell.statusLbl.textColor=[UIColor greenColor];
    }
    else{
        NSLog(@"Rejected.......");
        cell.statusLbl.text=@"Rejected";
        cell.statusLbl.textColor=[UIColor redColor];
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
    self.navigationItem.title = [@"LIBRARY_PANEL_MY_LOGS" localize];
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
