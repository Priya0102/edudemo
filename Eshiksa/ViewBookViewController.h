//
//  ViewBookViewController.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface ViewBookViewController : UIViewController<UIScrollViewDelegate,NIDropDownDelegate,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    IBOutlet UIButton *bookCategoryBtnSelect;
    
    NIDropDown *dropDown1;
}
@property (weak, nonatomic) IBOutlet UIButton *getBookBtn;
@property (weak, nonatomic) IBOutlet UILabel *bookCategory;
@property (weak, nonatomic) IBOutlet UILabel *bookId;
@property (weak, nonatomic) IBOutlet UILabel *bookDesc;

@property (nonatomic,retain) NSString *bookCategoryStr,*bookIdStr,*bookDescstr;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextField *bookName;
@property(nonatomic,retain)NSString*tag,*success,*error,*successMsg;
@property (weak, nonatomic) IBOutlet UITextField *publisherTxt;
@property (weak, nonatomic) IBOutlet UITextField *accessionNumText;
@property (weak, nonatomic) IBOutlet UITextField *authorTxt;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *bookCategoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *getBookLbl;

@property (weak, nonatomic) IBOutlet UILabel *publishLbl;
@property (weak, nonatomic) IBOutlet UILabel *accessionTxt;
@property (weak, nonatomic) IBOutlet UILabel *authorLbl;


@end
