//
//  FetchCollegeAttendanceVC.m
//  Eshiksa
//
//  Created by Punit on 12/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "FetchCollegeAttendanceVC.h"
#import "Constant.h"
#import "Base.h"
#import "BaseViewController.h"
#import "FetchColAttend.h"
#import "FetchCollegeAttendanceCell.h"
#import "PostAttendanceCollegeVC.h"
@interface FetchCollegeAttendanceVC (){
    BOOL isFiltered;
    NSString *shouldShowSearchResults;
    BOOL trigger;
    NSArray *newArray;
    
}

@end

@implementation FetchCollegeAttendanceVC
@synthesize isFiltered;
@synthesize searchBar;
@synthesize selectedArr;
@synthesize isCheck;
@synthesize isStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchBar.delegate = (id)self;
    
    [self.tableview delegate];
    [self.tableview dataSource];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    
    _studentIdArr=[[NSMutableArray alloc]init];
    _firstNameArr=[[NSMutableArray alloc]init];
    _lastNameArr=[[NSMutableArray alloc]init];
    _rollNumArr=[[NSMutableArray alloc]init];
    _studentArr=[[NSMutableArray alloc]init];
    
    [self parsingFetchedSchoolAttendance];
    
    selectedArr =[[NSMutableArray alloc]init];
    
    self.submitAttendanceBtn.layer.masksToBounds=YES;
    self.submitAttendanceBtn.layer.cornerRadius=8;
    
}
- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
    
    if(searchText.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        _filteredArray = [[NSMutableArray alloc] init];
        
       /* for (FetchColAttend *f in _studentArr)
        {
            NSRange nameRange = [f.firstNameStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [f.description rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [_filteredArray addObject:f];
            }
        }*/
        
        for (NSDictionary *temp in _studentArr)
        {
            NSRange nameRange = [[temp objectForKey:@"first_name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound )
            {
                [_filteredArray addObject:temp];
            }
        }
    }
    
    [self.tableview reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

-(void)parsingFetchedSchoolAttendance
{
    [_studentIdArr removeAllObjects];
    [_firstNameArr removeAllObjects];
    [_lastNameArr removeAllObjects];
    [_rollNumArr removeAllObjects];
    [_studentArr removeAllObjects];
    
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
    
    NSString *batchid = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"batchId"];
    NSLog(@"batchid in circular==%@",batchid);
    
    NSString *courseid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"courseId"];
    NSLog(@"courseid in circular==%@",courseid);
    
    NSString *departmentId = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"departmentId"];
    NSLog(@"departmentId in circular==%@",departmentId);
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"sessionId"];
    NSLog(@"sessionId in circular==%@",sessionId);
    
    NSString *subId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"subId"];
    NSLog(@"subId in circular==%@",subId);
    
    NSString *date = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"date"];
    NSLog(@"date in circular==%@",date);

    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:teacherclgattendance]];

    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag":@"get_student",
                                    @"course_id":courseid,
                                    @"batch_id":batchid,
                                    @"dept_id":departmentId,
                                    @"subject_id":subId,
                                    @"semester_id":sessionId,
                                    @"date":date
                                    };
    NSLog(@"PARAMETER DIC in college =%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  circular data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            _studentcount=[maindic objectForKey:@"studentcount"];
            _flag=[maindic objectForKey:@"flag"];
         
            
            NSLog(@"tag==%@& success=%@ studentcount==%@& flag=%@",_tag,_success,_studentcount,_flag);
            if([_flag isEqualToString:@"True"]){
                
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Attendance has been taken already." preferredStyle:UIAlertControllerStyleAlert];
                
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
            else{
            NSArray *ciculararr=[maindic objectForKey:@"studentList"];
            NSLog(@"studentList:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Currently there is no attendance data." preferredStyle:UIAlertControllerStyleAlert];
                
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
                
                 _studentArr=[[NSMutableArray alloc]init];
                
                for(NSDictionary *temp in ciculararr)
                {
                     NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                    
                    NSString *str1=[[temp objectForKey:@"student_id"]description];
                    NSString *str2=[[temp objectForKey:@"class_roll_no"]description];
                    NSString *str3=[temp objectForKey:@"first_name"];
                    NSString *str4=[temp objectForKey:@"last_name"];
                    NSString *str5=[temp objectForKey:@"status"];
                    NSString *str6=[temp objectForKey:@"isCheck"];
                    
                    isStatus=@"false";
                    str5=isStatus;
                    isCheck=@"N";
                    str6=isCheck;
                    
                    NSLog(@"_isStatus %@", isStatus);
                    NSLog(@"_isCheck %@", isCheck);
                
                    [dic setValue:str1 forKey:@"student_id"];
                    [dic setValue:str2 forKey:@"class_roll_no"];
                    [dic setValue:str3 forKey:@"first_name"];
                    [dic setValue:str4 forKey:@"last_name"];
                    [dic setValue:str5 forKey:@"status"];
                    [dic setValue:str6 forKey:@"isCheck"];
                    
                    
                     [_studentArr addObject:dic];
         
                }
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
    NSUInteger rowCount;
    if(self.isFiltered)
        rowCount = _filteredArray.count;
    else
        rowCount = _studentArr.count;
    
    return rowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FetchCollegeAttendanceCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(isFiltered){
        
        NSDictionary *dicFiltered=[_filteredArray objectAtIndex:indexPath.row];
        
        NSLog(@"dictionary===%@",dicFiltered);
        
        cell.studentId.text=[[dicFiltered objectForKey:@"student_id"]description];
        cell.rollNum.text=[[dicFiltered objectForKey:@"class_roll_no"]description];
        cell.firstName.text=[[dicFiltered objectForKey:@"first_name"]description];
        cell.lastName.text=[[dicFiltered objectForKey:@"last_name"]description];
        cell.attendanceStatus.text=[[dicFiltered objectForKey:@"status"]description];
        cell.studentFullName.text=[[[dicFiltered objectForKey:@"first_name"]description] stringByAppendingString:[[dicFiltered objectForKey:@"last_name"]description]];
        NSLog(@"studentFullName.text=%@ ",cell.studentFullName.text);

    
        return cell;
    }else{
        
        NSDictionary *d=[_studentArr objectAtIndex:indexPath.row];
        cell.studentId.text=[[d objectForKey:@"student_id"]description];
        cell.rollNum.text=[[d objectForKey:@"class_roll_no"]description];
        cell.firstName.text=[[d objectForKey:@"first_name"]description];
        cell.lastName.text=[[d objectForKey:@"last_name"]description];
        cell.attendanceStatus.text=[[d objectForKey:@"status"]description];
        cell.studentFullName.text=[[[d objectForKey:@"first_name"]description] stringByAppendingString:[[d objectForKey:@"last_name"]description]];
        NSLog(@"studentFullName.text=%@ status=%@",cell.studentFullName.text,cell.attendanceStatus.text);
        
        
        cell.studentSelectBtn.tag=indexPath.row;
        NSLog(@"Selectted cell indexpath===%ld",(long)cell.studentSelectBtn.tag);
        
        
        [cell.studentSelectBtn setTag:indexPath.row];
        
        [cell.studentSelectBtn addTarget:self action:@selector(studentselectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([selectedArr containsObject:self.studentArr [indexPath.row]]) {
            [cell.studentSelectBtn setImage:[UIImage imageNamed:@"checkedAttendance.png"] forState:UIControlStateNormal];
            [cell.studentSelectBtn setUserInteractionEnabled:YES];
            
            NSLog(@"selected array count=%ld",selectedArr.count);
        }
        else{
            
            [cell.studentSelectBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
            [cell.studentSelectBtn setUserInteractionEnabled:YES];
            
        }
    
        return cell;
    }
    
    
    return cell;
}
-(void)studentselectBtnClicked:(UIButton *)sender{
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"indexPath.row: %ld", button.tag);
    
    if ([selectedArr containsObject:self.studentArr[button.tag]])
    {
        [selectedArr removeObject:self.studentArr[button.tag]];
    }
    else{
        [selectedArr addObject:self.studentArr[button.tag]];
    }
    [_tableview reloadData];
    
}

- (IBAction)submitAttendanceBtnClicked:(id)sender {
    
    NSLog(@"SUBMIT Btn Click...........");
    if([_flag isEqualToString:@"True"]){
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Attendance has been taken already." preferredStyle:UIAlertControllerStyleAlert];
        
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
    else{
    [self performSegueWithIdentifier:@"postCollegeAttendance"
                              sender:self];
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    unsigned long int absentCount=[_studentArr count]-[selectedArr count];
    NSLog(@"absent count=%ld",absentCount);
    
    NSMutableArray *unselectedArray = [NSMutableArray arrayWithArray:_studentArr];
    [unselectedArray removeObjectsInArray:selectedArr];
    NSLog(@"*****unselectedArray=%@",unselectedArray);
    
    NSMutableArray *selectedArrCopy=[[NSMutableArray alloc]init];
    
    for (NSDictionary *selectDic in selectedArr) {
        NSMutableDictionary *selectedModified=[[NSMutableDictionary alloc]initWithDictionary:selectDic];
        
        [selectedModified setObject:@"Y" forKey:@"isCheck"];
        [selectedModified setObject:@"true" forKey:@"status"];
        
        [selectedArrCopy addObject:selectedModified];
    }
    
    newArray=selectedArr?[selectedArrCopy arrayByAddingObjectsFromArray:unselectedArray]:[[NSArray alloc] initWithArray:unselectedArray];
    NSLog(@"New array===%@",newArray);
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@(absentCount) forKey:@"absentCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:@([_studentArr count]) forKey:@"totalCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:@([selectedArr count]) forKey:@"presentCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if([[segue identifier] isEqualToString:@"postCollegeAttendance"])
    {
        PostAttendanceCollegeVC *ab=[segue destinationViewController];
        ab.studentArrayList =newArray;
        
    }
}


@end
