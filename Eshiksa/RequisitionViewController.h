//
//  RequisitionViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface RequisitionViewController : UIViewController<UIScrollViewDelegate,NIDropDownDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UIButton *requisitionBtnSelect;
    
    NIDropDown *dropDown1;
}
@property (weak, nonatomic) IBOutlet UITextField *requisitionTitle;
@property (weak, nonatomic) IBOutlet UITextField *investmentAmt;
@property (weak, nonatomic) IBOutlet UITextField *requisitionType;
@property (weak, nonatomic) IBOutlet UITextField *requisitionDetails;
- (IBAction)registerRequisitionBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reisterReqBtn;
@property (weak, nonatomic) IBOutlet UITextView *reqTxtView;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*successMsg;

@property (weak, nonatomic) IBOutlet UILabel *registerReqLbl;
@property (weak, nonatomic) IBOutlet UILabel *reqTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *reqTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *investmentLbl;
@property (weak, nonatomic) IBOutlet UILabel *reqDetailsLbl;
@property (weak, nonatomic) IBOutlet UILabel *registerReqBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *poweredByLbl;



@end
