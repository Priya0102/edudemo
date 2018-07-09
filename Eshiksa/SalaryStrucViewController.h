//
//  SalaryStrucViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalaryStrucViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *payableAmtArr,*payableNameArr,*payableArr,*deducatableArr,*deductableNameArr,*deductableAmtArr;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITableView *tableview2;
@property (weak, nonatomic) IBOutlet UILabel *empNmae;
@property (weak, nonatomic) IBOutlet UILabel *department;
@property (weak, nonatomic) IBOutlet UILabel *empSalary;
@property (nonatomic,strong) NSString *success,*error,*tag,*empsalarystructure,*countDeductable,*countPayable,*departmentstr,*empNamestr,*empSalarystr;
@property (weak, nonatomic) IBOutlet UILabel *salaryStructure;
@property (weak, nonatomic) IBOutlet UILabel *empNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *departmentLbl;
@property (weak, nonatomic) IBOutlet UILabel *salaryLbl;
@property (weak, nonatomic) IBOutlet UILabel *payableLbl;
@property (weak, nonatomic) IBOutlet UILabel *poweredLbl;

@end
