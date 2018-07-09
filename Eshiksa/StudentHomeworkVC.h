//
//  StudentHomeworkVC.h
//  Eshiksa
//
//  Created by Punit on 04/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentHomeworkVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *submissionDateArr,*homeworkNameArr,*subjectNameArr,*homeworkPathArr,*homeworkArr;
@property(nonatomic,retain)NSString *indxp;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*homeworkList;

@property (strong, nonatomic) IBOutlet UITextView *noSchedule;
@end
