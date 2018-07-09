//
//  HomeWorkTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeWorkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *submissionDate;
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *homeworkName;
@property (weak, nonatomic) IBOutlet UILabel *homeworkPath;
@property (weak, nonatomic) IBOutlet UILabel *homeworkHalfUrl;
@property (weak, nonatomic) IBOutlet UILabel *downloadBtn;

@end
