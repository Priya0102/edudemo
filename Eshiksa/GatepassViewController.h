//
//  GatepassViewController.h
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RzTextField.h"
@interface GatepassViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet RzTextField *fromDateTxtField;
    IBOutlet RzTextField *toDateTxtField;
    IBOutlet RzTextField *fromTimeTxtField;
    IBOutlet RzTextField *toTimeTxtField;
}

@property (weak, nonatomic) IBOutlet UITextView *requestTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

//
//@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
//@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
//
//@property (weak, nonatomic) IBOutlet UIView *hiddenView
//;
//@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker2;
//@property (weak, nonatomic) IBOutlet UIToolbar *toolbar2;
//
//@property (weak, nonatomic) IBOutlet UIView *hiddenView2
//;

@property(nonatomic,retain)NSString*tag,*success,*error,*successMsg;
@property (weak, nonatomic) IBOutlet UILabel *submitLbl;
@property (weak, nonatomic) IBOutlet UILabel *contactLbl;
@property (weak, nonatomic) IBOutlet UILabel *requestLbl;

@end
