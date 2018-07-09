//
//  LibraryMyLogViewController.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryMyLogViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *booknameArr,*issuedDateArr,*dueDateArr,*fineAmtArr,*statusArr,*mylogArr;

@end
