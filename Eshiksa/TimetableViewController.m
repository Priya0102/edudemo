//
//  TimetableViewController.m
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.

#import "TimetableViewController.h"
#import "TimetableTableViewCell.h"
#import "Timetable.h"
#import "TimetableObj.h"
#import "BaseViewController.h"
#import "Constant.h"
#import "Base.h"
@interface TimetableViewController ()
{
    NSMutableDictionary *dayDic;
    NSMutableArray *dayArr;
}

@end

@implementation TimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    
    [_tableview setSeparatorColor:[UIColor clearColor]];
    
    [self.segmentView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    day = @"Monday";
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
  
    _detailArr=[[NSMutableArray alloc]init];
    _timetableArr=[[NSMutableArray alloc]init];
    _subjectnameArr=[[NSMutableArray alloc]init];
    _subjectIdArr=[[NSMutableArray alloc]init];
    _lectureNameArr=[[NSMutableArray alloc]init];
    _lectureTimingArr=[[NSMutableArray alloc]init];
    _studentTimetableArr=[[NSMutableArray alloc]init];
    _breakArr=[[NSMutableArray alloc]init];
    _teacherNameArr=[[NSMutableArray alloc]init];

    [self parsingTimetable];
   [self segvaluechanged:_segmentView];
   [_segmentView setUserInteractionEnabled:YES];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  
 
}
-(void)parsingTimetable{
    
    
        [dayArr removeAllObjects];
        [_detailArr removeAllObjects];
        [_breakArr removeAllObjects];
        [_teacherNameArr removeAllObjects];
        [_subjectnameArr removeAllObjects];
        [_subjectIdArr removeAllObjects];
        [_lectureNameArr removeAllObjects];
        [_lectureTimingArr removeAllObjects];
        [_studentTimetableArr removeAllObjects];
        [_timetableArr removeAllObjects];
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in timetable==%@",groupname);
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"timetable username ==%@",username);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"timetable branchid ==%@",branchid);
    
   // NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/studentclgtimetable.php";
    
     //NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:pgParams]];
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:studentclgtimetable]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"tag": @"studentclgtimetable"
                                    };
    NSLog(@"parameter dic=%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response  timetable data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            _section=[maindic objectForKey:@"section"];
            _count=[maindic objectForKey:@"count"];
            _studenttimetable=[maindic objectForKey:@"student_timetable"];
            
            NSLog(@"tag==%@& success=%@",_tag,_success);
            
             dayDic=[[NSMutableDictionary alloc]init];
            
            NSArray *studentTimetable=[maindic objectForKey:@"student_timetable"];
            
            if(studentTimetable.count==0)
            {
                _segmentView.hidden=YES;
                _viewSeg.hidden=YES;
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"There is no timetable data" preferredStyle:UIAlertControllerStyleAlert];
                
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
            dayArr=[[NSMutableArray alloc]init];
            for (NSDictionary *temp1 in studentTimetable)
            {
             _name=[temp1 objectForKey:@"name"];
             _detail=[temp1 objectForKey:@"detail"];
                
                NSDictionary *dic=[temp1 objectForKey:@"name"];
                
                TimetableObj *tobj=[[TimetableObj alloc]init];
                tobj.dayStr=[dic objectForKey:@"day"];
               
                day=tobj.dayStr;
                [dayArr addObject:day];
                
                NSLog(@"dayStr==%@",tobj.dayStr);
                
                NSMutableArray *subarr=[temp1 objectForKey:@"detail"];
               
                NSMutableArray *tTablearr=[[NSMutableArray alloc]init];
                
            for(NSDictionary *temp in subarr)
            {
                NSString *str1=[[temp objectForKey:@"lecture_name"]description];
                NSString *str2=[[temp objectForKey:@"lecture_timing"]description];
                NSString *str3=[[temp objectForKey:@"teacher_name"]description];
                NSString *str4=[[temp objectForKey:@"subject_name"]description];
                NSString *str5=[[temp objectForKey:@"subject_id"]description];
                NSString *str6=[[temp objectForKey:@"break"]description];
               
                Timetable *t=[[Timetable alloc]init];
                t.lectureNameStr=str1;
                t.lectureTimingStr=str2;
                t.teacherNameStr=str3;
                t.subjectnameStr=str4;
                t.subjectIdStr=str5;
                t.breakStr=str6;
            
                [tTablearr addObject:t];
            }
              /*   if ([day isEqualToString:@"Tuesday"]) {
                    Timetable *t=[[Timetable alloc]init];
                    t.lectureNameStr=@"Tuesday";
                    t.lectureTimingStr=@"xxxxx";
                    t.teacherNameStr=@"xxxxx";
                    t.subjectnameStr=@"xxxxx";
                    t.subjectIdStr=@"xxxxx";
                    t.breakStr=@"xxxxx";
                    
                    [tTablearr addObject:t];
                } //for testing purpose weather selected segment is correct fetching data or not
               */
                
                 [dayDic setObject:tTablearr forKey:day];
                
            }
            _timetableArr=[dayDic objectForKey:day];
            [_tableview reloadData];
      }
    }
     [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
     }];

}

- (IBAction)segvaluechanged:(id)sender
    {
        day=[dayArr objectAtIndex:_segmentView.selectedSegmentIndex];
        _timetableArr=[dayDic objectForKey:day];
        if (_timetableArr!=NULL) {
            
             [_tableview reloadData];
        }
        NSLog(@"day in segment value=%@",day);
       
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
        
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return _timetableArr.count;
        
    }
     
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        TimetableTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        Timetable *sess=[_timetableArr objectAtIndex:indexPath.row];
        
        cell.lectureName.text=sess.lectureNameStr;
        cell.lectureTiming.text=sess.lectureTimingStr;
        cell.subjectname.text=sess.subjectnameStr;
        cell.subjectId.text=sess.subjectIdStr;
        
        NSLog(@"subject name=%@",cell.subjectname.text);
     
        //[_segmentView setUserInteractionEnabled:YES];

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
    self.navigationItem.title = [@"TIMETABLE" localize];
}

@end
