//
//  ForgotPassViewController.h
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,strong) NSString *success,*error,*tag,*successMsg;
@property (weak, nonatomic) IBOutlet UILabel *submitTxt;

@end
