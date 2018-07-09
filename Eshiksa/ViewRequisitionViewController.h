//
//  ViewRequisitionViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewRequisitionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *requistionDateArr,*requisitionTypeArr,*requisitionDetailsArr,*statusArr,*viewReqArr;

@property(nonatomic,retain)NSString *indxp,*reqIdStr;

@end
