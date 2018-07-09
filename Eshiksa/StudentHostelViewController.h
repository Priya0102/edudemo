//
//  StudentHostelViewController.h
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentHostelViewController : UIViewController
- (IBAction)roomRequestBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *hostelRoomReqLbl;
@property (weak, nonatomic) IBOutlet UILabel *hostelChangeReqLbl;
@property (weak, nonatomic) IBOutlet UILabel *myHostelLbl;
@property (weak, nonatomic) IBOutlet UILabel *hostelExitLbl;

@end
