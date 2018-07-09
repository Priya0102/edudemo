//jduyjryhjuduyrhrjjn  fgrbffbfvdfv//
//  PaidFeesViewController.h
//  Eshiksa
//
//  Created by Punit on 07/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaidFeesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *billNumberArr,*createdDateArr,*feesNameArr,*payStatusArr,*feesAmountArr,*fineAmountArr,*paidAmountArr,*paidArr;
//@property (strong, nonatomic) IBOutlet UITextView *noSchedule;
@property(nonatomic,retain)NSString *indxp;

@end
