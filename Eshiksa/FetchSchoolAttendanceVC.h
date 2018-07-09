//
//  FetchSchoolAttendanceVC.h
//  Eshiksa
//
//  Created by Punit on 08/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchSchoolAttendanceVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>

//@property (weak, nonatomic)IBOutlet UITextField *studentARR;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *studentIdArr,*rollNumArr,*firstNameArr,*lastNameArr,*studentArr;

@property(nonatomic,retain)NSString *studentIdStr,*rollNumStr,*firstNameStr,*lastnameStr,*fullNameStr,*attendanceStatusStr;
@property(nonatomic,retain)NSString *isStatus,*isCheck;



@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableArray *filteredArray,*selectedArr,*tickarray;
@property (nonatomic, assign) bool isFiltered;
@property (weak, nonatomic) IBOutlet UIButton *submitAttendanceBtn;
@property (nonatomic,strong) NSString *success,*flag,*error,*tag,*studentcount,*date;



@end

