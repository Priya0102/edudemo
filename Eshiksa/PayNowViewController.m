//
//  PayNowViewController.m
//  Eshiksa
//
//  Created by Punit on 08/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "PayNowViewController.h"
#import "Constant.h"
#import "PayNow.h"
#import "WebViewController.h"
#import "Base.h"
@interface PayNowViewController ()
{
    NSString *totalAmountPaid;
}
@end

@implementation PayNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.proceedBtn.layer.masksToBounds=YES;
    self.proceedBtn.layer.cornerRadius=16;
    
    _batchid.text=_batchIdStr;
    _sessionId.text=_sessionIdStr;
    _departmentId.text=_departmentIdStr;
    _courseid.text=_courseIdStr;
    _studentId.text=_studentIdStr;
    
     NSLog(@"SESSION ID=%@ batch id=%@ department id=%@ courseIdStr=%@ studentIdStr=%@",_sessionIdStr,_batchIdStr,_departmentIdStr,_courseIdStr,_studentIdStr);
    
    //[self excessAmountDataParsing];
   
}

- (IBAction)creditCardBtnClicked:(id)sender {
    NSLog(@"CREDIT CARD BTN CLICKED...");
    _cardtypeStr=@"creditcard";
    [_creditCardBtn setImage:[UIImage imageNamed:@"clicked64.png"]forState:UIControlStateNormal];
    [_debitCardBtn setImage:[UIImage imageNamed:@"unclicked64.png"]forState:UIControlStateNormal];
    [_netBankingBtn setImage:[UIImage imageNamed:@"unclicked64.png"]forState:UIControlStateNormal];
}

- (IBAction)debitCardBtnClicked:(id)sender {
    NSLog(@"DEBIT CARD BTN CLICKED...");
    _cardtypeStr=@"debitcard";
    [_debitCardBtn setImage:[UIImage imageNamed:@"clicked64.png"] forState:UIControlStateNormal];
    [_creditCardBtn setImage:[UIImage imageNamed:@"unclicked64.png"]forState:UIControlStateNormal];
    [_netBankingBtn setImage:[UIImage imageNamed:@"unclicked64.png"]forState:UIControlStateNormal];
}
- (IBAction)netBankingBtnClicked:(id)sender {
       NSLog(@"NET BANKING  BTN CLICKED...");
    _cardtypeStr=@"netbanking";
    [_netBankingBtn setImage:[UIImage imageNamed:@"clicked64.png"] forState:UIControlStateNormal];
    [_creditCardBtn setImage:[UIImage imageNamed:@"unclicked64.png"]forState:UIControlStateNormal];
    [_debitCardBtn setImage:[UIImage imageNamed:@"unclicked64.png"]forState:UIControlStateNormal];

}
- (IBAction)proceedBtnClicked:(UIButton *)sender {
    
      NSLog(@"proceed BTN CLICKED...");
    
    [self pgParamsDataParsing];
    
    [self performSegueWithIdentifier:@"showPayInfo"
                              sender:self];
    
}
-(void)pgParamsDataParsing{
    
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
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"requisition password ==%@",password);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    
    //NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo_ios/pgParams.php"];
    
    NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:pgParams]];
  
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id": orgid,
                                    @"cyear": cyear,
                                    @"url":str,
                                    @"tag": @"fees",
                                    @"password": password,
                                 
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response pgParams:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _merchantId=[maindic objectForKey:@"merchantId"];
             _pgURL=[maindic objectForKey:@"pgURL"];
             _pgAction=[maindic objectForKey:@"pgAction"];
             _instId=[maindic objectForKey:@"instId"];
            _instName=[maindic objectForKey:@"instname"];
            _pgName=[maindic objectForKey:@"pgName"];
            _encryptKey=[maindic objectForKey:@"encryptKey"];
            _pgCCComission=[maindic objectForKey:@"pgCCComission"];
            _pgDCComission=[maindic objectForKey:@"pgDCComission"];
            _pgNBComissionStr=[maindic objectForKey:@"pgNBComission"];
            _pgUrlStr=[maindic objectForKey:@"appPgURL"];
            
            NSLog(@"tag==%@& success=%@  _merchantId =%@ pgCCComission=%@ debit pgDCComission=%@ netbanking pgNBComission=%@",_tag,_success,_merchantId,_pgCCComission,_pgDCComission,_pgNBComissionStr);
            
            [[NSUserDefaults standardUserDefaults] setObject:_encryptKey forKey:@"encryptkey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
         
            [[NSUserDefaults standardUserDefaults] setObject:_pgName forKey:@"pgname"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:_merchantId forKey:@"merchantid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:_pgNBComissionStr forKey:@"pgnetbanking"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *amountAdded = [[NSUserDefaults standardUserDefaults]
                                     stringForKey:@"amountadded"];
            NSLog(@"amountAdded ==%@",amountAdded);
            
            NSString *amountadded2 = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"amountadded2"];
            NSLog(@"amountadded2 ==%@",amountadded2);
            
            int result=[amountAdded intValue]+[_pgNBComissionStr intValue]-[amountadded2 intValue];
            totalAmountPaid = [NSString stringWithFormat:@"%d", result];
            NSLog(@"totalAmountPaid==  %@",totalAmountPaid);
            
            [[NSUserDefaults standardUserDefaults] setObject:totalAmountPaid forKey:@"totalAmountPaid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
       
            
            // $    check[0]['FEES_AMOUNT']+$check[0]['fine_amount']+$check[0]['pg_commission']-($check[0]['concession_amount']+$check[0]['discount_amount']);
            
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:@"Data saved successfully" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                          [self savePgParamsDataParsing];
                                         
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                     }];
                [alertView addAction:ok];
               
                [self presentViewController:alertView animated:YES completion:nil];

            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"No data found" preferredStyle:UIAlertControllerStyleAlert];
                
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
-(void)savePgParamsDataParsing{
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
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"requisition password ==%@",password);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    NSString *pgname = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"pgname"];
    NSLog(@"pgname==%@",pgname);
    
    NSString *encryptkey = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"encryptkey"];
    NSLog(@"encryptKey==%@",encryptkey);
    
    NSString *merchantid = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"merchantid"];
    NSLog(@"merchantId==%@",merchantid);
    
    
    NSString *totalAmountPaid = [[NSUserDefaults standardUserDefaults]
                                 stringForKey:@"totalAmountPaid"];
    NSLog(@"*****totalAmountPaid ==%@",totalAmountPaid);
    
//    NSString *feesAmount = [[NSUserDefaults standardUserDefaults]
//                            stringForKey:@"feesAmount"];
//    NSLog(@"feesAmount==%@",feesAmount);
    
//    NSString *excessAmount = [[NSUserDefaults standardUserDefaults]
//                            stringForKey:@"excessAmount"];
//    NSLog(@"excessAmount==%@",excessAmount);
    
    NSString *feesId = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"feesId"];
    NSLog(@"feesId in card type     ==%@",feesId);
   
    
    NSString *pgnetbanking = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"pgnetbanking"];
    NSLog(@"pgnetbanking==%@",pgnetbanking);


     _udf1 = [NSString stringWithFormat: @"%@ %s %@ %s %@ %s %@ %s %@ %s %@ %s %d %s %d %s %@ %s %d", feesId,"_",_studentIdStr,"_",_courseIdStr,"_",_batchIdStr,"_",totalAmountPaid,"_",pgnetbanking,"_",0,"_",0,"_",username,"_",0];
    
    NSLog(@"UDF DATA==%@",_udf1);
    
    //0 _ 261740 _ 2908 _ 3897 _ 1200 _ 0 _  _  _ JASL3111 _ 1200
    /*
     "pay_method":"debitcard",
     "udf1":"8585_121277_1381_1883_1200_0.00_0_0_RAJV129121277_0",
     feesId_studentId_courseId_batchId_totalAmount_charge_departmentId_sessionID_username_userExcessAmt
     0 _ 261742 _ 2908 _ 3897 _ 2600 _ 0 _ 0 _ 0 _ ARVI311261742 _ 2600

     */
    
    /*
     {
     "Branch_id":"129",
     "amount":1200,
     "charge":"0.00",
     "dbname":"erpeshik_esh_slave",
     "groupname":"Student",
     "instUrl":"http://erp.eshiksa.net/eps",
     "key":"160",
     "password":"12345",
     "pay_method":"debitcard",
     "pgName":"atom",
     "salt":"Test@123",
     "surl":"http://shop.eshiksa.com/appAPI_v2/",
     "tag":"savePGData",
     "udf1":"8585_121277_1381_1883_1200_0.00_0_0_RAJV129121277_0",
     "udf2":"erpeshik_esh_slave",
     "udf3":"129",
     "url":"http://shop.eshiksa.com/appAPI_v2/savePGData_v2.php",
     "user_name":"17DUMM121950"
     }
     
     */
    //http://shop.eshiksa.com/appAPI_v2_edemo/savePGData_v2.php
    
      NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:savePGData_v2]];

    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id": orgid,
                                    @"cyear": cyear,
                                    @"url":str,
                                    @"tag":@"savePGData",
                                    @"password": password,
                                    @"amount":totalAmountPaid,
                                    @"charge":pgnetbanking,
                                    @"key":merchantid,
                                    @"pay_method":_cardtypeStr,
                                    @"pgName":pgname,
                                    @"salt":encryptkey,
                                    @"surl":mainUrl,
                                    //@"surl":@"http://shop.eshiksa.com/appAPI_v2/",
                                    @"udf1":_udf1,
                                    @"udf2":dbname,
                                    @"udf3":branchid
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);

    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data in save pg...:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[maindic objectForKey:@"error"];
            _tempIdStr=[maindic objectForKey:@"tempId"];
            _txnIdStr=[maindic objectForKey:@"txnid"];
            _concessionStatusStr=[maindic objectForKey:@"concession_status"];

            NSLog(@"tag==%@& success=%@  _txnIdStr =%@  _tempIdStr=%@  _concessionStatusStr=%@",_tag,_success,_txnIdStr,_tempIdStr,_concessionStatusStr);
            
            NSString *txnid=_txnIdStr;
            NSLog(@"txnid---%@",txnid);
            
            [[NSUserDefaults standardUserDefaults] setObject:_txnIdStr forKey:@"transactionId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
          NSLog(@"***transactionId***** = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"transactionId"]);
        
        
            if([self.success isEqualToString:@"1"])
            {
                NSLog(@"success.....");
            }
            else
            {
                NSLog(@"failure.....");
            }
        }
    }];
}
-(void)excessAmountDataParsing{
    
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
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"requisition password ==%@",password);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);

    NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:excess_amount]];

    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id": orgid,
                                    @"cyear": cyear,
                                    @"url":str,
                                    @"tag": @"excess_amount",
                                    @"password": password,
                                    
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"excess data response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            
            NSLog(@"tag==%@& success=%@",_tag,_success);
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
            }];
            
            NSDictionary *dic=[maindic objectForKey:@"excess_data"];
            
           NSLog(@"excess data:%@",dic);
            
                
            PayNow *p=[[PayNow alloc]init];
            p.feesid=[dic objectForKey:@"fees_id"];
            p.feesName=[dic objectForKey:@"fees_name"];
            p.feesAmount=[dic objectForKey:@"fees_amount"];
            p.excessAmount=[dic objectForKey:@"excess_amount"];
            
            NSLog(@"feesid:::%@ feesName :%@ excessAmount id:%@",[dic objectForKey:@"fees_id"],p.feesName,p.excessAmount);
                if(p.feesid==(NSString *) [NSNull null])
                {
                    p.feesid=@"0";
                }
                if(p.feesAmount==(NSString *) [NSNull null])
                {
                    p.feesAmount=@"0";
                }
                if(p.excessAmount==(NSString *) [NSNull null])
                {
                    p.excessAmount=@"0";
                }
                if(p.feesName==(NSString *) [NSNull null])
                {
                    p.feesName=@"-";
                }
            
            [[NSUserDefaults standardUserDefaults] setObject:p.excessAmount forKey:@"excessAmount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
          
    
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showPayInfo"]) {
        
        NSString *txnid = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"transactionId"];
        NSLog(@"***transactionId ==%@",txnid);
        
        NSString *branchid = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"branchid"];
        NSLog(@"***branchid ==%@",branchid);
        
        NSString *totalAmountPaid = [[NSUserDefaults standardUserDefaults]
                                     stringForKey:@"totalAmountPaid"];
        NSLog(@"*****totalAmountPaid ==%@",totalAmountPaid);
        
       
        NSString *myst=[NSString stringWithFormat:@"plugin=payment&action=pay&txnid=%@&branch_id=%@&amount=%@",txnid,branchid,totalAmountPaid];
        
        NSLog(@"my string commentsss=%@",myst);
        
    
       // NSString *str = [@"http://eps.eshiksa.net/esh/index.php?" stringByAppendingString:myst];//LIVE URL
        NSString *str = [@"http://erp.eshiksa.net/edemo_fees/esh/index.php?" stringByAppendingString:myst];
        
        wvc.myURL=str;
        
        NSLog(@"*******full str=%@",str);
        
        //wvc.myURL=@"http://erp.eshiksa.net/edemo_fees/esh/index.php?plugin=payment&action=pay&txnid=esh_5af40add0cf3f&branch_id=65&amount=2400";
       
        
        //http://eps.eshiksa.net/esh/index.php?plugin=payment&action=pay&student_id=200978&txnid=esh_5b026f5895ba6&amount=100&branch_id=312 //new db working url
        
   // http://eps.eshiksa.net/esh/index.php?plugin=payment&action=pay&txnid=esh_5b026f5895ba6&branch_id=311&amount=776

       // http://erp.eshiksa.net/edemo_fees/esh/index.php?plugin=payment&action=pay&txnid=esha_858545c4a4f807db0b0e&branch_id=311&amount=2600
        
       // http://eps.eshiksa.net/esh/index.php?plugin=payment&action=pay&txnid=esha_cee04e586b939357f869&branch_id=311&amount=1200
    
    }
}

@end
