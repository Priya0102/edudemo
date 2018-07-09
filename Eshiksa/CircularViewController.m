//
//  CircularViewController.m
//  Eshiksa
//
//  Created by Punit on 23/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//
//  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:abc]];

#import "CircularViewController.h"
#import "CircularTableViewCell.h"
#import "BaseViewController.h"
#import "CircularDetailsViewController.h"
#import "Circular.h"
#import "Constant.h"
#import "Base.h"
@interface CircularViewController ()

@end

@implementation CircularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _circularArr=[[NSMutableArray alloc]init];
    _circularIdArr=[[NSMutableArray alloc]init];
    _titleArr=[[NSMutableArray alloc]init];
    _publishDateArr=[[NSMutableArray alloc]init];
    _publishInDateArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingCircular];
}
-(void)parsingCircular
{
    [_circularArr removeAllObjects];
    [_circularIdArr removeAllObjects];
    [_titleArr removeAllObjects];
    [_publishDateArr removeAllObjects];
    [_publishInDateArr removeAllObjects];
    
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
    
    
   // NSURL *urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:auth]];
    
     //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/newcircular.php";
    
     NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:newcircular]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag":@"circularlist"
                                   };

    
      [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {

                                        NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
                                        NSLog(@"response  circular data:%@",maindic);
                                        NSArray *ciculararr=[maindic objectForKey:@"circular"];
                                        NSLog(@"ciculararr:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no circular data." preferredStyle:UIAlertControllerStyleAlert];
                
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
                                            NSString *str1=[[temp objectForKey:@"id"]description];
                                            NSString *str2=[[temp objectForKey:@"title"]description];
                                            NSString *str3=[temp objectForKey:@"publish_date"];
                                            NSString *str4=[temp objectForKey:@"publish_todate"];
                                        
                                            
                                            NSLog(@"id=%@  title=%@ publish_date=%@ publish_todate=%@",str1,str2,str3,str4);
                                            
                                          
                                            Circular *k1=[[Circular alloc]init];
                                            k1.circularIdStr=str1;
                                            k1.titleStr=str2;
                                            k1.publishDateStr=str3;
                                            k1.publishToDateStr=str4;
                                           
                                            
                                            [_circularArr addObject:k1];
                                            
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
    return _circularArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircularTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Circular *ktemp=[_circularArr objectAtIndex:indexPath.row];
    
    cell.circularId.text=ktemp.circularIdStr;
    cell.title.text=ktemp.titleStr;
    cell.publishDate.text=ktemp.publishDateStr;
    cell.publishToDate.text=ktemp.publishToDateStr;
    
    cell.readMoreTxt.text = [@"READ_MORE" localize];
    cell.publishDateTxt.text=[@"PUBLISH_DATE" localize];
    cell.toDateTxt.text = [@"TO_DATE" localize];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CircularTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _circularIdStr=cell.circularId.text;
  
    _titleStr=cell.title.text;
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"indexpath==%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"circularDetails"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"circularDetails"])
    {
        
       CircularDetailsViewController *kvc = [segue destinationViewController];
        
        kvc.titleStr=_titleStr;
        kvc.circularIdStr=_circularIdStr;
        kvc.indxpath=_indxp;
        
 NSLog(@"indexpath in prepare for segue==%@",_circularIdStr);
    }
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewDidLoad];
//    
//   CircularTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    Circular *ktemp=[_circularArr objectAtIndex:indexPath.row];
//    cell.readMoreTxt.text = [@"READ_MORE" localize];
//    cell.publishDateTxt.text=[@"PUBLISH_DATE" localize];
//    cell.toDateTxt.text = [@"TO_DATE" localize];
//    
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
//}

-(void)changeLanguage:(NSNotification*)notification
{
//    readMoreTxt.text = [@"READ_MORE" localize];
//    publishDateTxt.text=[@"PUBLISH_DATE" localize];
//    toDateTxt.text = [@"TO_DATE" localize];
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"CIRCULAR" localize];
}

@end
