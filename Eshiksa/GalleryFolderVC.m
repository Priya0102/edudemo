//
//  GalleryFolderVC.m
//  Eshiksa
//
//  Created by Punit on 02/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GalleryFolderVC.h"

@interface GalleryFolderVC ()

@end

@implementation GalleryFolderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.folderId.text=_folderIdStr;
    NSLog(@"FOLDER ID===%@",_folderIdStr);
    
    [[NSUserDefaults standardUserDefaults] setObject:_folderIdStr forKey:@"folderid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
