

#import "MyReportViewController.h"
#import "BaseViewController.h"
#import "Base.h"
#import "Constant.h"
#import "APIManager.h"

@interface MyReportViewController ()
{
    NSData *imgName;
}
@end

@implementation MyReportViewController
@synthesize reportTitleLbl;
@synthesize reportDateLbl;
@synthesize fileUploadLbl;
@synthesize saveReportLbl;
@synthesize poweredBylbl;
@synthesize myReportLbl;
@synthesize filechooseLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgName=NULL;
    
    [dateTxtField setDelegate:self];
    [dateTxtField setDateField:YES];
    
    self.saveReportBtn.layer.masksToBounds=YES;
    self.saveReportBtn.layer.cornerRadius=8;
    
    arrimg =[[NSMutableArray alloc]init];
}

-(void)ShowPicker {
    
    CGFloat Height = self.view.frame.size.height;
    CGFloat Width = self.view.frame.size.width;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(PressDone)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    
    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height-200, Width, 200)];
    picker.backgroundColor = [UIColor greenColor];
    
    [picker addSubview:numberToolbar];
    [self.view addSubview:picker];
}

-(void)PressDone {
    
    NSLog(@"SELECTED DATE IS===");
    
}
- (IBAction)saveReportClicked:(id)sender  {
   [self dataUpload];
    if ([UploadType isEqualToString:@"PDF"])
    {
        [self uploadpdf];
    }
    else
        [self uploadimage];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    myReportLbl.text = [@"MY_REPORT" localize];
    reportTitleLbl.text=[@"REPORT_TITLE" localize];
    reportDateLbl.text = [@"REPORT_DATE" localize];
    fileUploadLbl.text=[@"FILE_UPLOAD" localize];
    saveReportLbl.text=[@"SAVE_REPORT" localize];
    poweredBylbl.text=[@"POWERED_BY" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
    
    [super viewDidAppear:(BOOL)animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)changeLanguage:(NSNotification*)notification
{
    myReportLbl.text = [@"MY_REPORT" localize];
    reportTitleLbl.text=[@"REPORT_TITLE" localize];
    reportDateLbl.text = [@"REPORT_DATE" localize];
    fileUploadLbl.text=[@"FILE_UPLOAD" localize];
    saveReportLbl.text=[@"SAVE_REPORT" localize];
    poweredBylbl.text=[@"POWERED_BY" localize];
    
}
//new uploading using afnetworking icloud on required
#pragma mark- Choose File or Image
- (IBAction)browseFile:(id)sender

{
  
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Photo option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Take Photo ",
                            @"Choose Existing",@"Documents",nil];
    
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
}

#pragma  mark- Opne Action Sheet for Options

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    
                    imagePicker = [[UIImagePickerController alloc] init];
                  
                    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
                    imagePicker.delegate = self;
               
                    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                    [self presentViewController:imagePicker animated:YES completion:nil];
                    
                    
                    break;
                case 1:
                    
                    imagePicker = [[UIImagePickerController alloc] init];
                    
                    imagePicker.delegate = self;
                    
                    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                    
                    [self presentViewController:imagePicker animated:YES completion:nil];
                    
                    break;
                    
                case 2:
                    
                    [self showDocumentPickerInMode:UIDocumentPickerModeOpen];
                    
                    break;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark- Open Document Picker(Delegate) for PDF, DOC Slection from iCloud


- (void)showDocumentPickerInMode:(UIDocumentPickerMode)mode
{
    
    UIDocumentMenuViewController *picker =  [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[@"com.adobe.pdf"] inMode:UIDocumentPickerModeImport];
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker
{
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
    
    
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller
  didPickDocumentAtURL:(NSURL *)url
{
    PDFUrl= url;
    UploadType=@"PDF";
    [arrimg removeAllObjects];
    [arrimg addObject:url];
    NSLog(@"pdf url.......%@",url);
    
}

#pragma mark- Open Image Picker Delegate to select image from Gallery or Camera
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UploadType=@"Image";
    [arrimg removeAllObjects];
    [arrimg addObject:myImage];
     NSLog(@"myImage url.......%@",myImage);
    [picker dismissViewControllerAnimated:YES completion:NULL];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editingInfo{
  
    [picker dismissModalViewControllerAnimated:YES];
    NSURL *imagePath = [editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSString *imageName = [imagePath lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSLog(@"localFilePath.%@",localFilePath);
    filechooseLbl.text=localFilePath;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - Upload Image, PDF or Doc to Server
-(void)uploadimage
{
    //loader start
    APIManager *obj =[[APIManager alloc]init];
    [obj setDelegate:(id)self];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setValue:@"default" forKey:@"jpeg"];
    [dict setValue:@"defaulttitle" forKey:@"title"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:empMyReport]];

    NSURL *url =[NSURL URLWithString:urlString];
    [obj startRequestForImageUploadingWithURL:url withRequestType:(kAPIManagerRequestTypePOST) withDataDictionary:dict arrImage:arrimg CalledforMethod:imageupload index:0 isMultiple:NO str_imagetype:@"image"];
}

#pragma mark - Upload PDF

-(void)uploadpdf
{
    APIManager *obj =[[APIManager alloc]init];
    [obj setDelegate:(id)self];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setValue:@"default" forKey:@"pdf"];
    [dict setValue:@"defaulttitle" forKey:@"title"];
    NSString *urlString = [NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:empMyReport]];
    NSURL *url =[NSURL URLWithString:urlString];
    [obj startRequestForImageUploadingWithURL:url withRequestType:(kAPIManagerRequestTypePOST) withDataDictionary:dict arrImage:arrimg CalledforMethod:imageupload index:0 isMultiple:NO str_imagetype:@"pdf"];
    
}

#pragma mark-API Manager Delegate Method for Succes or Failure
-(void)APIManagerDidFinishRequestWithData:(id)responseData withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName tag:(NSInteger)tag
{
    if (APImethodName ==imageupload) {
        NSDictionary *responsedata=(NSDictionary*)responseData;
        NSLog(@"data==%@",responsedata);
        
        NSString * Success= [responsedata valueForKey:@"success"];
        NSString * Message= [responseData valueForKey:@"message"];
        
        BOOL SuccessBool= [Success boolValue];
        
        if (SuccessBool)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Server Error" message:Message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                                                  }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

-(void)APIManagerDidFinishRequestWithError:(NSError *)error withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName tag:(NSInteger)tag
{
    if (APImethodName ==imageupload) {
        
        NSLog(@"image did..failedupload");
    }
}
-(void)dataUpload{
    {
//        if(!imgName)
//        {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please select image" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
//            [alert addAction:defaultAction];
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//        else{
            @try
            {
                NSString *groupname = [[NSUserDefaults standardUserDefaults]
                                       stringForKey:@"groupName"];
                NSLog(@"group name in requisition==%@",groupname);
                NSString *branchid = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"branchid"];
                NSLog(@"requisition branchid ==%@",branchid);
                
                NSString *orgid = [[NSUserDefaults standardUserDefaults]
                                   stringForKey:@"orgid"];
                NSLog(@"requisition orgid ==%@",orgid);
                NSString *cyear = [[NSUserDefaults standardUserDefaults]
                                   stringForKey:@"cyear"];
                NSLog(@"requisition cyear ==%@",cyear);
                NSString *password = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"password"];
                NSLog(@"requisition password ==%@",password);
                
                NSString *username = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"username"];
                NSLog(@"profile username ==%@",username);
                
                NSString *urlString=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:empMyReport]];
                
                NSString *filename = @"file";
                NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:urlString]];
                [request setHTTPMethod:@"POST"];
                NSString *boundary = @"---------------------------14737809831466499882746641449";
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                NSMutableData *postbody = [NSMutableData data];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:   NSUTF8StringEncoding]];
                
            
                
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"groupname\"\r\n\r\n%@",groupname] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
                NSLog(@"post:%@",postbody);
                
                ////adding username////
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n%@",username] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                 ////adding tag////
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"tag\"\r\n\r\n%@",@"insert_myreport"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding instUrl////
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"instUrl\"\r\n\r\n%@",instUrl] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding dbname////
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"dbname\"\r\n\r\n%@",dbname] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                ////adding branchid///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Branch_id\"\r\n\r\n%@",branchid] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding orgid///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"org_id\"\r\n\r\n%@",orgid] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding cyear///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cyear\"\r\n\r\n%@",cyear] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding urlString///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"url\"\r\n\r\n%@",urlString] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding password///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@",password] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////adding report_title///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"report_title\"\r\n\r\n%@",self.reportTitle.text] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                ////date///
                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"date\"\r\n\r\n%@",dateTxtField.text] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

                //------ image data ------

                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [postbody appendData:[NSData dataWithData:imgName]];
                [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [request setHTTPBody:postbody];
                
                
                NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:nil];
   
                NSString* newStr1 = [NSString stringWithUTF8String:[returnData bytes]];
                
                NSString* newStr2 = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                
                
                NSLog(@"%@,%@",newStr1,newStr2);
                
                
                NSLog(@"returnData:%@",returnData);
                
                NSData *jsonData =   returnData;
                NSError *error = nil;
                NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
                if(error)
                {
                    NSLog(@"err:%@",error);
                    
                }
                NSLog(@"dict1:%@",dict1);
                
                if(dict1!=NULL)
                {
                    NSString *responsestr=[dict1 valueForKey:@"success"];
                    NSLog(@"response==%@",responsestr);
                    
                    if([responsestr isEqualToString:@"0"])
                    {
                        NSLog(@"failed to upload ");
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops Something Went wrong " message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:defaultAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }
                    else
                    {
                        NSLog(@"thumbnail submitted successfully");
                        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:@"Report Submitted Successfully." preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* ok = [UIAlertAction
                                             actionWithTitle:@"OK"
                                             style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action)
                                             {
                                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                                 
                                             }];
                        
                        [alertView addAction:ok];
                        [self presentViewController:alertView animated:YES completion:nil];
                    }
                }
            }
            @catch (NSException *exception){}
       // }//imgname
   }
}


@end
