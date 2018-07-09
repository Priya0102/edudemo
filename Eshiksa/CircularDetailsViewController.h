//
//  CircularDetailsViewController.h
//  Eshiksa
//
//  Created by Punit on 25/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileDownloader.h"

@interface CircularDetailsViewController : UIViewController<fileDownloaderDelegate,UIWebViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *descriptionCircular;
@property (weak, nonatomic) IBOutlet UILabel *titleCircular;
@property (weak, nonatomic) IBOutlet UILabel *circularId;
@property (weak, nonatomic) IBOutlet UILabel *cir_file;
@property (weak, nonatomic) IBOutlet UIButton *attachmentBtn;

@property(nonatomic,retain)NSString *circularIdStr,*titleStr,*indxpath,*webView;
@property (weak, nonatomic) IBOutlet UILabel *attachmentTxt;
//@property (strong, nonatomic) IBOutlet UITextView *noSchedule;
@end
