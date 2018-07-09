//
//  WebViewController.m
//  Eshiksa
//
//  Created by Punit on 25/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_indicaor startAnimating];
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:self.myURL]];
    
    [self.webView loadRequest:req];
    
     [_indicaor stopAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
