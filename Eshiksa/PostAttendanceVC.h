//
//  PostAttendanceVC.h
//  Eshiksa
//
//  Created by Punit on 14/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostAttendanceVC : UIViewController

@property(nonatomic,retain) NSArray *studentArrayList;
@property (weak, nonatomic) IBOutlet UILabel *totalStudentCount;
@property (weak, nonatomic) IBOutlet UILabel *totalPresentCount;
@property (weak, nonatomic) IBOutlet UILabel *totalAbsentCount;
@property (weak, nonatomic) IBOutlet UILabel *postAttendanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalStudentLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPresentStudentLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalAbsentStudentLbl;
@property(nonatomic,retain)NSString*tag,*success,*error,*successMsg;

@property (weak, nonatomic) IBOutlet UIButton *postAttendanceBtn;

@end
