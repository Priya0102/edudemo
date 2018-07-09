//
//  TransportViewController.h
//  Eshiksa
//
//  Created by Punit on 09/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *transportArr,*routeIdArr,*routeNameArr,*pickDropArr,*stopIdArr,*stopName,*latitudeArr,*longitudeArr,*journeyDetailArr;



@end
