//
//  FetchCollegeAttendanceVC.h
//  Eshiksa
//
//  Created by Punit on 12/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchCollegeAttendanceVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *studentIdArr,*rollNumArr,*firstNameArr,*lastNameArr,*studentArr;

@property(nonatomic,retain)NSString *studentIdStr,*rollNumStr,*firstNameStr,*lastnameStr,*fullNameStr,*attendanceStatusStr;
@property(nonatomic,retain)NSString *isStatus,*isCheck;

@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (strong, nonatomic) UISearchController *searchController;
//@property (nonatomic,strong) NSArray *result;
//@property (nonatomic,strong) NSArray *searchresult;
@property (strong,nonatomic) NSMutableArray *filteredArray,*selectedArr;
@property (nonatomic, assign) bool isFiltered;
@property (weak, nonatomic) IBOutlet UIButton *submitAttendanceBtn;

@property (nonatomic,strong) NSString *success,*flag,*error,*tag,*studentcount;


@end
