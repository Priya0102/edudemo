//
//  HostelExitViewController.h
//  Eshiksa
//
//  Created by Punit on 02/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RzTextField.h"
@interface HostelExitViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    
IBOutlet RzTextField *fromDateTxtField;
       
    
}

@property (weak, nonatomic) IBOutlet UITextView *remark;
//@property (weak, nonatomic) IBOutlet UITextField *remarkDate;
@property (weak, nonatomic) IBOutlet UIButton *requestBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIView *hiddenView
;
@property (weak, nonatomic) IBOutlet UILabel *requestLbl;
@property (weak, nonatomic) IBOutlet UILabel *hostelRemarkLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;

@property(nonatomic,retain)NSString*tag,*success,*error,*successMsg;

@property (nonatomic,strong) NSMutableArray *remarkArr,*remarkDateArr,*remarkStatusArr,*remarkRequestedStatusArr,*remarkGivenArr;

@property (strong, nonatomic) IBOutlet UITextView *noSchedule;


@end
