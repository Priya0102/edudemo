//
//  GatepassViewRequest.h
//  Eshiksa
//
//  Created by Punit on 28/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatepassViewRequest : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *createdDateArr,*fromDateArr,*toDateArr,*statusArr,*gatepassArr;
@property(nonatomic,retain)NSString *indxp,*tag,*success,*error,*studentId;


@end
