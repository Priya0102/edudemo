//
//  MyReportViewController.h
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.

#import <UIKit/UIKit.h>
#import "RzTextField.h"
#import "APIManager.h"

@interface MyReportViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,APIManagerDelegate,UIDocumentPickerDelegate,UIDocumentMenuDelegate,UINavigationControllerDelegate>
{
    IBOutlet RzTextField *dateTxtField;
    
    UIDocumentPickerViewController *docPicker;
    UIImagePickerController *imagePicker;
    NSMutableArray *arrimg;
    
    NSString * UploadType;
    NSURL * PDFUrl;
    
}

-(void)myReportBtnClicked:(NSData *)imageData;
- (IBAction)browseFile:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *filechooseLbl;

@property (weak, nonatomic) IBOutlet UITextField *reportTitle;
@property (weak, nonatomic) IBOutlet UILabel *myReportLbl;
@property (weak, nonatomic) IBOutlet UILabel *reportTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *reportDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *fileUploadLbl;
@property (weak, nonatomic) IBOutlet UILabel *saveReportLbl;
@property (weak, nonatomic) IBOutlet UILabel *poweredBylbl;

@property (weak, nonatomic) IBOutlet UIButton *saveReportBtn;
@property (nonatomic,strong) NSString *success,*error,*tag,*successMsg,*imageName,*fieldName;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@end
