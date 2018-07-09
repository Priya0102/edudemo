//
//  LibraryPanelTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 27/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryPanelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *isbn;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *edition;
@property (weak, nonatomic) IBOutlet UILabel *publisher;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBooks;
@property (weak, nonatomic) IBOutlet UILabel *booksAvailable;
@property (weak, nonatomic) IBOutlet UIButton *requestBtn;
@property(nonatomic,retain)NSString *tag,*success,*error,*successMsg;

@end
