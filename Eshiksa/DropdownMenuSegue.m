//
//  DropdownMenuSegue.m
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "DropdownMenuSegue.h"
#import "DropdownMenuController.h"
@implementation DropdownMenuSegue

- (void) perform {
    
    DropdownMenuController *containerViewController = (DropdownMenuController *) self.sourceViewController;
    UIViewController *nextViewController = (UIViewController *) self.destinationViewController;
    UIViewController *currentViewController = (UIViewController *) containerViewController.currentViewController;
    
    // Add nextViewController as child of container view controller.
    [containerViewController addChildViewController:nextViewController];
    // Tell current View controller that it will be removed.
    [currentViewController willMoveToParentViewController:nil];
    
    // Set the frame of the next view controller to equal the outgoing (current) view controller
    nextViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    nextViewController.view.frame = currentViewController.view.frame;
    nextViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Make the transition with a very short Cross disolve animation
    [containerViewController transitionFromViewController:currentViewController
                                         toViewController:nextViewController
                                                 duration:0.1f
                                                  options:UIViewAnimationOptionTransitionCrossDissolve
                                               animations:^{
                                                   
                                               }
                                               completion:^(BOOL finished) {
                                                   containerViewController.currentViewController = nextViewController;
                                                   [currentViewController removeFromParentViewController];
                                                   [nextViewController didMoveToParentViewController:containerViewController];
                                               }];
    
}


@end
