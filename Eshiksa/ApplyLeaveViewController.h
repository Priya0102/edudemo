

#import <UIKit/UIKit.h>
#import "RzTextField.h"

@interface ApplyLeaveViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

{
    IBOutlet RzTextField *fromDateTxtField;
    IBOutlet RzTextField *toDateTxtField;
}
@property (weak, nonatomic) IBOutlet UITextView *reasonTxtField;
//@property (weak, nonatomic) IBOutlet UITextField *fromTxtField;
//@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTxtField;
@property (weak, nonatomic) IBOutlet UIButton *applyLeaveBtn;
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

@property (weak, nonatomic) IBOutlet UILabel *applyLeaveTxt;
@property (weak, nonatomic) IBOutlet UILabel *reasonTxt;
@property (weak, nonatomic) IBOutlet UILabel *fromDateTxt;
@property (weak, nonatomic) IBOutlet UILabel *toDateTxt;
@property (weak, nonatomic) IBOutlet UILabel *contactNumTxt;
@property (weak, nonatomic) IBOutlet UILabel *applyLeaveBtnTxt;



@end
