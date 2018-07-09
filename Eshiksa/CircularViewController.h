//
//  CircularViewController.h
//  Eshiksa
//
//  Created by Punit on 23/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *circularIdArr,*titleArr,*publishDateArr,*publishInDateArr,*circularArr;

@property(nonatomic,retain)NSString *indxp,*circularIdStr,*titleStr;





@end
