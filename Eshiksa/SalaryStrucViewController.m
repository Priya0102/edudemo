
//  SalaryStrucViewController.m
//  Created by Punit on 19/04/18.


#import "SalaryStrucViewController.h"
#import "Constant.h"
#import "Base.h"
#import "SalaryPayableTableViewCell.h"
#import "Salary.h"
#import "SalaryDeductTableViewCell.h"
#import "SalaryDeduct.h"
#import "BaseViewController.h"
@interface SalaryStrucViewController (){
    NSMutableDictionary *empsalarystructureDic;
}

@end

@implementation SalaryStrucViewController
@synthesize salaryStructure;
@synthesize empNameLbl;
@synthesize departmentLbl;
@synthesize salaryLbl;
@synthesize payableLbl;
@synthesize  poweredLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
      [self.tableview2 setSeparatorColor:[UIColor clearColor]];
    
    _payableArr=[[NSMutableArray alloc]init];
    _payableAmtArr=[[NSMutableArray alloc]init];
    _payableNameArr=[[NSMutableArray alloc]init];
    
    _deducatableArr=[[NSMutableArray alloc]init];
    _deductableNameArr=[[NSMutableArray alloc]init];
    _deductableAmtArr=[[NSMutableArray alloc]init];
   
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
  
    [self parsingSalary];
    [self parsingDeductableSalary];
}

-(void)parsingSalary
{
    
    [_payableArr removeAllObjects];
    [_payableAmtArr removeAllObjects];
    [_payableNameArr removeAllObjects];
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in profile==%@",groupname);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"profile password ==%@",password);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"profile orgid ==%@",orgid);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"profile branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"profile cyear ==%@",cyear);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:teacherSalaryStructure]];
    
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username": username,
       @"dbname":dbname,
       @"instUrl":instUrl,
       @"Branch_id":branchid,
       @"org_id":orgid,
       @"cyear":cyear,
       @"url": urlstr,
       @"tag": @"salaryStructure",
       @"password": password };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response salary data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            _empsalarystructure=[maindic objectForKey:@"empsalarystructure"];
            
            
            NSLog(@"tag==%@& success=%@ empsalary struct=%@",_tag,_success,_empsalarystructure);
            
            NSDictionary *dic=[maindic objectForKey:@"empsalarystructure"];
            
            self.empNmae.text=[dic objectForKey:@"emp_name"];
            self.department.text=[dic objectForKey:@"department"];
            self.empSalary.text=[dic objectForKey:@"emp_salary"];
            _countDeductable=[dic objectForKey:@"countDeductables"];
           _countPayable=[dic objectForKey:@"countPayables"];
            
              NSLog(@"emp_name==%@&   self.department.text=%@ ***empsalary struct=%@ _countDeductable=%@ _countPayable=%@",_empNamestr,  self.department.text,self.empSalary.text,_countDeductable,_countPayable);


            NSArray *ciculararr=[dic objectForKey:@"Payables"];
            NSLog(@"payable arr::%@",ciculararr);
            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"payable_amount"]description];
                NSString *str2=[[temp objectForKey:@"payable_name"]description];
                
                
                NSLog(@"payable_amount=%@  payable_name=%@",str1,str2);
                
                
                Salary *k1=[[Salary alloc]init];
                k1.payaableAmtStr=str1;
                k1.payableStr=str2;
                
                
                [_payableArr addObject:k1];
                
            }
     [_tableview reloadData];
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    
}
-(void)parsingDeductableSalary
{
    
    [_deductableAmtArr removeAllObjects];
    [_deductableNameArr removeAllObjects];
    [_deducatableArr removeAllObjects];
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in profile==%@",groupname);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"profile password ==%@",password);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"profile orgid ==%@",orgid);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"profile branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"profile cyear ==%@",cyear);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:teacherSalaryStructure]];
    
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username": username,
       @"dbname":dbname,
       @"instUrl":instUrl,
       @"Branch_id":branchid,
       @"org_id":orgid,
       @"cyear":cyear,
       @"url": urlstr,
       @"tag": @"salaryStructure",
       @"password": password };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response salary data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            _empsalarystructure=[maindic objectForKey:@"empsalarystructure"];
            
            
            NSLog(@"tag==%@& success=%@ empsalary struct=%@",_tag,_success,_empsalarystructure);
            
            NSDictionary *dic=[maindic objectForKey:@"empsalarystructure"];
            
            self.empNmae.text=[dic objectForKey:@"emp_name"];
            self.department.text=[dic objectForKey:@"department"];
            self.empSalary.text=[dic objectForKey:@"emp_salary"];
            _countDeductable=[dic objectForKey:@"countDeductables"];
            _countPayable=[dic objectForKey:@"countPayables"];
            
            NSLog(@"emp_name==%@&   self.department.text=%@ ***empsalary struct=%@ _countDeductable=%@ _countPayable=%@",_empNamestr,  self.department.text,self.empSalary.text,_countDeductable,_countPayable);
           
            
            NSArray *ciculararr=[dic objectForKey:@"Deductables"];
            NSLog(@"Deductables arr::%@",ciculararr);
            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"deductable_amount"]description];
                NSString *str2=[[temp objectForKey:@"deductable_name"]description];
                
                
                NSLog(@"deductable_amount=%@  deductable_name=%@",str1,str2);
                
                
                SalaryDeduct *k1=[[SalaryDeduct alloc]init];
                k1.deductAmtStr=str1;
                k1.deductNameStr=str2;
                
                
                [_deducatableArr addObject:k1];
            
            }
            [_tableview2 reloadData];
        }
        [_tableview2 performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tableview) {
        return 1;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableview) {
        return _payableArr.count;
    }
    return _deducatableArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==self.tableview) {
        
    SalaryPayableTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Salary *ktemp=[_payableArr objectAtIndex:indexPath.row];
    
    cell.payableName.text=ktemp.payableStr;
    cell.payableAmt.text=ktemp.payaableAmtStr;
        NSLog(@"PAYABLE NAME%@,PAYABLE AMT=%@",ktemp.payableStr,ktemp.payaableAmtStr);
        return cell;
    }
    else {
    SalaryDeductTableViewCell *cell = [_tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    SalaryDeduct *ktemp=[_deducatableArr objectAtIndex:indexPath.row];

    cell.deductName.text=ktemp.deductNameStr;
    cell.deductAmt.text=ktemp.deductAmtStr;
         NSLog(@"deductNameStr NAME%@,deductAmtStr AMT=%@",ktemp.deductNameStr,ktemp.deductAmtStr);
    return cell;
    }
    return cell;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    
    salaryStructure.text = [@"SALARY_STRUCTURE" localize];
    empNameLbl.text=[@"EMPLOYEE_NAME" localize];
    departmentLbl.text = [@"DEPARTMENT" localize];
    salaryLbl.text=[@"SALARY" localize];
    payableLbl.text=[@"PAYABLES" localize];
    poweredLbl.text=[@"POWERED_BY" localize];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)changeLanguage:(NSNotification*)notification
{
    salaryStructure.text = [@"SALARY_STRUCTURE" localize];
    empNameLbl.text=[@"EMPLOYEE_NAME" localize];
    departmentLbl.text = [@"DEPARTMENT" localize];
    salaryLbl.text=[@"SALARY" localize];
    payableLbl.text=[@"PAYABLES" localize];
     poweredLbl.text=[@"POWERED_BY" localize];
}

@end
