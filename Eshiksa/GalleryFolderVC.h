//
//  GalleryFolderVC.h
//  Eshiksa
//
//  Created by Punit on 02/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryFolderVC : UIViewController
@property(nonatomic,retain)NSString *folderIdStr,*titleStr,*indxpath;

@property (weak, nonatomic) IBOutlet UILabel *folderId;

@end
