
//  RequestLeaveViewController.h

//  Created by Punit on 19/04/18.


#import <UIKit/UIKit.h>
#import "RzTextField.h"
@interface RequestLeaveViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet RzTextField *fromDateTxtField;
    IBOutlet RzTextField *toDateTxtField;
    
}

@property (weak, nonatomic) IBOutlet UITextField *reasonTxtFld;
@property (weak, nonatomic) IBOutlet UITextView *reasontextview;
@property (weak, nonatomic) IBOutlet UIButton *requestLeaveBtn;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*successMsg;
@property (weak, nonatomic) IBOutlet UILabel *leaveLbl;
@property (weak, nonatomic) IBOutlet UILabel *reasonLbl;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *toDatelbl;
@property (weak, nonatomic) IBOutlet UILabel *reqLbl;
@property (weak, nonatomic) IBOutlet UILabel *poweredBy;

@end
