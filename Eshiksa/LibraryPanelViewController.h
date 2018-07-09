//
//  LibraryPanelViewController.h
//  Eshiksa
//
//  Created by Punit on 27/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryPanelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *nameArr,*isbnArr,*authorArr,*editionArr,*publisherArr,*numberOfBooksArr,*booksAvailableArr,*bookArr;

@property (strong, nonatomic) IBOutlet UITextView *noSchedule;
@property(nonatomic,retain)NSString*tag,*success,*error,*successMsg;
@end
