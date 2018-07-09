//
//  CircularTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 25/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *publishDate;
@property (strong, nonatomic) IBOutlet UILabel *publishToDate;
@property (strong, nonatomic) IBOutlet UILabel *readMoreBtn;
@property (strong, nonatomic) IBOutlet UILabel *circularId;
@property (strong, nonatomic) IBOutlet UIView *view;


@property (weak, nonatomic) IBOutlet UILabel *publishDateTxt;
@property (weak, nonatomic) IBOutlet UILabel *toDateTxt;
@property (weak, nonatomic) IBOutlet UILabel *readMoreTxt;

@end
