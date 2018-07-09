//
//  MyHostelViewController.h
//  Eshiksa
//
//  Created by Punit on 02/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHostelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,retain)NSString*tag,*success,*error,*studentId;

@property (nonatomic,strong) NSMutableArray *studentArr,*studentNameArr,*courseNameArr,*batchNameArr,*mobileNumArr,*hostelArr,*hostelNameArr,*issueDateArr,*floorNumArr,*roomNumArr;

@property (weak, nonatomic) IBOutlet UITableView *tableview2;

@property (weak, nonatomic) IBOutlet UILabel *myRoomLbl;
@property (weak, nonatomic) IBOutlet UILabel *roomPartnerLbl;
@property (strong, nonatomic) IBOutlet UITextView *noSchedule;


@end
