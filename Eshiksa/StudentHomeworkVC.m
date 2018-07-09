//
//  StudentHomeworkVC.m
//  Eshiksa
//
//  Created by Punit on 04/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "StudentHomeworkVC.h"
#import "StudentHomework.h"
#import "Constant.h"
#import "StudentHomeworkTableViewCell.h"
#import "BaseViewController.h"
#import "Base.h"
#import "WebViewController.h"
@interface StudentHomeworkVC ()

@end

@implementation StudentHomeworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    _homeworkArr=[[NSMutableArray alloc]init];
    _homeworkNameArr=[[NSMutableArray alloc]init];
    _subjectNameArr=[[NSMutableArray alloc]init];
    _submissionDateArr=[[NSMutableArray alloc]init];
    _homeworkPathArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingHomeworkData];
}
-(void)parsingHomeworkData
{
    [_homeworkArr removeAllObjects];
    [_homeworkNameArr removeAllObjects];
    [_subjectNameArr removeAllObjects];
    [_submissionDateArr removeAllObjects];
    [_homeworkPathArr removeAllObjects];
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
    
    
   // NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/homework.php";
    
     NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:homework]];
    
       NSDictionary *parameterDict = @{
                                @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"tag":@"homework"
                                    };
    
    NSLog(@"parameterDict data:%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        
        NSLog(@"response data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  homework_list data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _homeworkList=[maindic objectForKey:@"homework_list"];
            
            NSLog(@"tag==%@& success=%@  _homeworkList=%@",_tag,_success,_homeworkList);
            
            NSArray *ciculararr=[maindic objectForKey:@"homework_list"];
        
            NSLog(@"homework_list:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                
                _noSchedule = [[UITextView alloc]initWithFrame:
                               CGRectMake(80, 200, 400, 300)];
                [_noSchedule setText:@"No homework is given..."];
                [_noSchedule setTextColor:[UIColor grayColor]];
                [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:16]];
                _noSchedule.delegate =self;
                [self.view addSubview:_noSchedule];
            
            
            }
            else {

            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"subject"]description];
                NSString *str2=[[temp objectForKey:@"submission_date"]description];
                NSString *str3=[temp objectForKey:@"hw_name"];
                NSString *str4=[temp objectForKey:@"hw_file"];
                
                
                NSLog(@"subject=%@  submission_date=%@ hw_name=%@ hw_file=%@",str1,str2,str3,str4);
                
                
                StudentHomework *k1=[[StudentHomework alloc]init];
                k1.subjectNameStr=str1;
                k1.submissionDateStr=str2;
                k1.homeworkStr=str3;
                k1.homeworkpathStr=str4;
                
                
                [_homeworkArr addObject:k1];
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
    return _homeworkArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentHomeworkTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    StudentHomework *ktemp=[_homeworkArr objectAtIndex:indexPath.row];
    
    cell.submissionDate.text=ktemp.submissionDateStr;
    cell.subject.text=ktemp.subjectNameStr;
    cell.homeworkName.text=ktemp.homeworkStr;
    cell.homeworkHalfUrl.text=ktemp.homeworkpathStr;
    
    NSString *str = [homeworkdownloadUrl stringByAppendingString:ktemp.homeworkpathStr];
    cell.homeworkPath.text=str;
    
    NSLog(@"homeworkPath URL in cell %@",str);
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"homeworkPath"];
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
    self.navigationItem.title = [@"HOMEWORK" localize];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    StudentHomeworkTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"indexpath==%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"showStudentHomeworkDownload"
                              sender:[self.tableview cellForRowAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showStudentHomeworkDownload"]) {
        
        NSString *homeworkPath = [[NSUserDefaults standardUserDefaults]stringForKey:@"homeworkPath"];
        NSLog(@"***homeworkPath ==%@",homeworkPath);
        
        wvc.myURL=homeworkPath;
        
        NSLog(@"*******full downloading url  str=%@",homeworkPath);
        
    }
}

@end
