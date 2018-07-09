//
//  StudentViewController.h
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UIButton *galleryBtn;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImg;
@property (weak, nonatomic) IBOutlet UIButton *paidBtn;
@property (weak, nonatomic) IBOutlet UIImageView *paidImg;
@property (weak, nonatomic) IBOutlet UIButton *circularBtn;
@property (weak, nonatomic) IBOutlet UIImageView *circularImg;
@property (weak, nonatomic) IBOutlet UIButton *payfeeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *payfeeImg;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIImageView *settingImg;

@property (weak, nonatomic) IBOutlet UILabel *profiletxt;
@property (weak, nonatomic) IBOutlet UILabel *circulartext;
@property (weak, nonatomic) IBOutlet UILabel *gallerytxt;
@property (weak, nonatomic) IBOutlet UILabel *payfeestxt;
@property (weak, nonatomic) IBOutlet UILabel *paidfeestxt;
@property (weak, nonatomic) IBOutlet UILabel *settingstxt;
@property (weak, nonatomic) IBOutlet UILabel *poweredBy;

@property (nonatomic,strong) NSString *success,*email,*error,*tag,*user;

@end
