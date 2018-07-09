//
//  ViewBookViewController.m
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//
#import "BaseViewController.h"
#import "ViewBookViewController.h"
#import "NIDropDown.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#import "Base.h"
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@interface ViewBookViewController ()
{
     NSMutableArray *keyarr1,*keyarr2;
}
@end

@implementation ViewBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    bookCategoryBtnSelect.layer.borderWidth = 1;
    bookCategoryBtnSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    bookCategoryBtnSelect.layer.cornerRadius = 5;
    
    _getBookBtn.layer.cornerRadius = 5;
self.bookName.layer.borderColor=[[UIColor lightGrayColor] CGColor];
self.searchBar.frame=CGRectMake(196,172,120.0,40.0);

}

-(IBAction)bookCategoryBtnClicked:(id)sender {
    
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
    
   // NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/library.php";
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:library]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag": @"book_category"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  books_category data:%@",maindic);
            
            keyarr1= [[NSMutableArray alloc]init];
            keyarr2=[[NSMutableArray alloc]init];
            
            NSArray *keyarr= (NSArray*)[maindic objectForKey:@"books_category"];
            
            // NSUInteger count=sizeof(keyarr);
            NSUInteger count = [keyarr count];
            NSUInteger i=0;
            
            for(NSDictionary *temp in keyarr)
            {
                NSString *str1=[temp objectForKey:@"id"];
                NSString *str2=[temp objectForKey:@"name"];
                NSString *str3=[temp objectForKey:@"description"];
                
                if(count>i)
                {
                    [keyarr1 addObject:str2];
                    [keyarr2 addObject:str1];
                    
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        _bookId.text=_bookIdStr;
                        _bookCategory.text=_bookCategoryStr;
                        _bookDesc.text=_bookDescstr;
                        
                        NSLog(@"**_bookIdStr id==%@ _bookCategory name==%@ _bookDesc==%@",str1,str2,str3);
                        
//                        [[NSUserDefaults standardUserDefaults] setObject:_bookIdStr forKey:@"bookid"];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                        
                    }];
                    
                    //NSString *test=[keyarr1 objectAtIndex:i];
                }
                i++;
            }
            NSArray * arrImage = [[NSArray alloc] init];
            
            if(dropDown1 == nil) {
                CGFloat f = 120;
                dropDown1 = [[NIDropDown alloc]showDropDown:sender :&f :keyarr1 :arrImage :@"down"];
                
                dropDown1.delegate = self;
            }
            else {
                [dropDown1 hideDropDown:sender];
                [self rel];
            }
        }
        
    }];
}
//    NSArray * arr = [[NSArray alloc] init]; //Static
//    arr = [NSArray arrayWithObjects:@"Demo Category",@"Test Category",@"Catelog",nil];
//    
//    NSArray * arrImage = [[NSArray alloc] init];
//    
//    if(dropDown1 == nil) {
//        CGFloat f = 120;
//        dropDown1 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
//        
//        dropDown1.delegate = self;
//    }
//    else {
//        [dropDown1 hideDropDown:sender];
//        [self rel];
//    }
    


-(void)rel{
    //    dropDown2 = nil;
    //    dropDown1=nil;
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    
    [self rel];
    NSUInteger i = [keyarr1 indexOfObject:bookCategoryBtnSelect.titleLabel.text];
    NSLog(@"INTEGER==%lu",(unsigned long)i);
    NSLog(@"VENUE LBL==%@",bookCategoryBtnSelect.titleLabel.text);
    NSString *serviceId = keyarr2[i];

    NSLog(@"***bookCategoryBtnSelect====%@",bookCategoryBtnSelect.titleLabel);
    
    [[NSUserDefaults standardUserDefaults]setValue:serviceId forKey:@"bookId"];
    NSLog(@"***bookId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"bookId"]);
    
}
- (IBAction)getBookBtnClicked:(id)sender {
 
    NSLog(@"get Button Clicked==");
 
    if (dropDown1==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select mandatory fields before going further" preferredStyle:UIAlertControllerStyleAlert];
 
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
    else{
        [self getBookClickParsing];
    }
}
-(void)getBookClickParsing{
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
    
    NSString *bookid = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"bookId"];
    NSLog(@"get btn clickedlibrary bookid ==%@",bookid);
    
    
    //NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/library.php"];
     NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:library]];
 
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id": orgid,
                                    @"cyear": cyear,
                                    @"url":str,
                                    @"tag": @"book_request",
                                    @"password": password,
                                    @"book_id":bookid,
    
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _successMsg=[maindic objectForKey:@"success_msg"];
            
            NSLog(@"tag==%@& success=%@  success msg=%@",_tag,_success,_successMsg);
            
            //  dispatch_async(dispatch_get_main_queue(), ^{
            
            //NSString *codeR = [[object objectForKey:@"success"] stringValue];
            // mysterious missing code
            //if ([coreR isEqualToString:@"200"])
            
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:@"Search is available." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                self.publisherTxt.text=@"";
                self.accessionNumText.text=@"";
                self.authorTxt.text=@"";
                self.bookCategory.text=@"";
                self.bookName.text=@"";
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"No search match available" preferredStyle:UIAlertControllerStyleAlert];
                
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
    }];
    
    
    
    
    
}

- (IBAction)bookNameSearchTxtFld:(UITextField *)sender {
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
    NSString *bookid = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"bookId"];
    NSLog(@"library bookid ==%@",bookid);
    
    NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/library.php";
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":@"erpeshik_esh_slave_edemo_new",
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url": @"http://shop.eshiksa.com/appAPI_v2_edemo/library.php",
                                    @"tag": @"books",
                                    @"category":bookid,
                                    @"book_name":self.bookName.text
                                    };
    
    [[NSUserDefaults standardUserDefaults]setValue:self.bookName.text forKey:@"bookName"];
    NSLog(@"***bookId = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"bookId"]);
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  book name data:%@",maindic);
        }
        
    }];

    
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"LIBRARY_PANEL_VIEW_BOOKS" localize];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    _bookNameLbl.text = [@"LIBRARY_PANEL_BOOK_NAME" localize];
    _publishLbl.text = [@"PUBLISHER" localize];
    _accessionTxt.text = [@"ACCESSION_NO" localize];
    _authorLbl.text = [@"AUTHOR" localize];
    _bookCategoryLbl.text = [@"CATEGORY" localize];
    _bookCategory.text = [@"CATEGORY" localize];
    _getBookLbl.text = [@"LIBRARY_PANEL_FETCH_BOOKS" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    _bookNameLbl.text = [@"LIBRARY_PANEL_BOOK_NAME" localize];
    _publishLbl.text = [@"PUBLISHER" localize];
    _accessionTxt.text = [@"ACCESSION_NO" localize];
    _authorLbl.text = [@"AUTHOR" localize];
    _bookCategoryLbl.text = [@"CATEGORY" localize];
    _bookCategory.text = [@"CATEGORY" localize];
    _getBookLbl.text = [@"LIBRARY_PANEL_FETCH_BOOKS" localize];
    
    
}



@end
