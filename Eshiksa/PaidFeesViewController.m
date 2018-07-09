//
//  PaidFeesViewController.m
//  Eshiksa
//
//  Created by Punit on 07/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import "PaidFeesViewController.h"
#import "Constant.h"
#import "PaidFees.h"
#import "PaidFeesTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
#import "WebViewController.h"
                                                        
@interface PaidFeesViewController ()

@end

@implementation PaidFeesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [_tableview setSeparatorColor:[UIColor clearColor]];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _billNumberArr=[[NSMutableArray alloc]init];
    _createdDateArr=[[NSMutableArray alloc]init];
    _feesNameArr=[[NSMutableArray alloc]init];
    _payStatusArr=[[NSMutableArray alloc]init];
    _feesAmountArr=[[NSMutableArray alloc]init];
    _fineAmountArr=[[NSMutableArray alloc]init];
    _paidAmountArr=[[NSMutableArray alloc]init];
    _paidArr=[[NSMutableArray alloc]init];
    
    [self parsingPaidFees];
    
}

-(void)parsingPaidFees{
    
    [_billNumberArr removeAllObjects];
    [_createdDateArr removeAllObjects];
    [_feesNameArr removeAllObjects];
    [_payStatusArr removeAllObjects];
    [_feesAmountArr removeAllObjects];
    [_fineAmountArr removeAllObjects];
    [_paidAmountArr removeAllObjects];
    [_paidArr removeAllObjects];
   


    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:abc]];
    
    
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

    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo_ios/fees_v2.php";

    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:fees_v2]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url": urlstr,
                                    @"tag":@"paid"
                                    };
   
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  paid fees data:%@",maindic);
                       
            NSArray *ciculararr=[maindic objectForKey:@"paid_fees"];
            NSLog(@"paid_fees0000:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
            
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"No data available" preferredStyle:UIAlertControllerStyleAlert];
                    
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
                
       for (NSArray *coverUrlArray in ciculararr) {
           
            for(NSDictionary *temp in coverUrlArray)
            {
                NSString *str1=[temp objectForKey:@"bill_number"];
                NSString *str2=[[temp objectForKey:@"created_date"]description];
                NSString *str3=[[temp objectForKey:@"fees_name"]description];
                NSString *str4=[[temp objectForKey:@"pay_status"]description];
                NSString *str5=[[temp objectForKey:@"fees_amount"]description];
                NSString *str6=[[temp objectForKey:@"fine_amount"]description];
                NSString *str7=[[temp objectForKey:@"paid_amount"]description];
                NSString *str8=[[temp objectForKey:@"due_amount"]description];
                NSString *str9=[[temp objectForKey:@"student_id"]description];
                NSString *str10=[[temp objectForKey:@"first_name"]description];
                NSString *str11=[[temp objectForKey:@"last_name"]description];
                NSString *str12=[[temp objectForKey:@"admission_no"]description];
                NSString *str13=[[temp objectForKey:@"transaction_number"]description];
                NSString *str14=[[temp objectForKey:@"paid_from"]description];
                NSString *str15=[[temp objectForKey:@"total_paid_amount"]description];
                NSString *str16=[[temp objectForKey:@"receipt_download"]description];
                NSString *str17=[[temp objectForKey:@"fees_receipt"]description];
                
                NSLog(@"bill_number=%@  title=%@ publish_date=%@ publish_todate=%@",str1,str2,str3,str4);
                if (([(NSString*)str1 isEqual: [NSNull null]])) {
                    // Showing AlertView Here
                }else {
                    
                PaidFees *k1=[[PaidFees alloc]init];
                k1.billNumStr=str1;
                k1.createdDateStr=str2;
                k1.feesNameStr=str3;
                k1.payStatusStr=str4;
                k1.feesAmountStr=str5;
                k1.fineAmountStr=str6;
                k1.paidAmtStr=str7;
                    k1.dueAmtStr=str8;
                    k1.studentIdStr=str9;
                    k1.firstNameStr=str10;
                    k1.lastNameStr=str11;
                    k1.admissiomNumStr=str12;
                    k1.transactionNumStr=str13;
                    k1.paidFromStr=str14;
                    k1.totalPaidAmtStr=str15;
                    k1.reciecptDownloadStr=str16;
                    k1.feesRecieptStr=str17;
//
                [_paidArr addObject:k1];
                
                [_tableview reloadData];
            }
           }
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
    return _paidArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaidFeesTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PaidFees *ktemp=[_paidArr objectAtIndex:indexPath.row];
    
    cell.billNumber.text=ktemp.billNumStr;
    cell.createdDate.text=ktemp.createdDateStr;
    cell.feesName.text=ktemp.feesNameStr;
    cell.payStatus.text=ktemp.payStatusStr;
    cell.feesAmount.text=ktemp.feesAmountStr;
    cell.fineAmount.text=ktemp.fineAmountStr;
    cell.paidAmount.text=ktemp.paidAmtStr;
    cell.feesReciept.text=ktemp.feesRecieptStr;
    
    NSLog(@"fees reciept url==%@",ktemp.feesRecieptStr);
    
    //NSString *str = [@"http://erp.eshiksa.net/edemo_fees/esh" stringByAppendingString:ktemp.feesRecieptStr];
    NSString *str = [downloadUrl stringByAppendingString:ktemp.feesRecieptStr];
    cell.feesRecieptUrl.text=str;
    
    NSLog(@"FEES rECIEPT URL %@",str);
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"feeReciept"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
    self.navigationItem.title = [@"PAID_FEES" localize];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    PaidFeesTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"indexpath==%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"showDownload"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showDownload"]) {
        
        NSString *feeReciept = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"feeReciept"];
        NSLog(@"***feeReciept ==%@",feeReciept);

        wvc.myURL=feeReciept;
        
        NSLog(@"*******full downloading url str=%@",feeReciept);
        
        
    }
}

@end
