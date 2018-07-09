//
//  DropdownMenuController.h
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownMenuController : UIViewController
@property (strong,nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UIView *menubar;
@property (strong, nonatomic) IBOutlet UIView *menu;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

- (IBAction) displayGestureForTapRecognizer:(UITapGestureRecognizer *) recognizer;
- (IBAction) menuButtonAction: (UIButton *) sender;
- (IBAction) listButtonAction: (UIButton *) sender;

- (void) setTrianglePlacement: (float) trianglePlacementVal;
- (void) setFadeAmountWithAlpha:(float) alphaVal;
- (void) setFadeTintWithColor:(UIColor *) color;
- (void) dropShapeShouldShowWhenOpen:(BOOL)shouldShow;
- (void) setMenubarTitle:(NSString *) menubarTitle;
- (void) setMenubarBackground:(UIColor *) color;
- (void) toggleMenu;
- (void) showMenu;
- (void) hideMenu;


@end
