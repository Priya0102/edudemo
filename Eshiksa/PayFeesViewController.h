//
//  PayFeesViewController.h
//  Eshiksa
//
//  Created by Punit on 08/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayFeesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *feesNameArr,*feesAmountArr,*dueDateArr,*dueAmountArr,*paidAmountArr,*totalConcessionAmountArr,*headFineAmountArr,*payArr;

@property(nonatomic,retain)NSString *indxp,*totalAmtStr,*courseIdStr,*batchIdStr,*departmentIdStr,*sessionIdStr,*studentIdStr;
//@property (strong, nonatomic) IBOutlet UITextView *noSchedule;

@end
