//
//  GalleryViewController.m
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCollectionViewCell.h"
#import "Constant.h"
#import "Gallery.h"
#import "GalleryDetailViewController.h"
#import "BaseViewController.h"
#import "Base.h"
#import "GalleryFolderVC.h"
@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _galleryArr=[[NSMutableArray alloc]init];
    _foldernameArr=[[NSMutableArray alloc]init];
    _folderIdArr=[[NSMutableArray alloc]init];
    _imgIdArr=[[NSMutableArray alloc]init];
    
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    
    
    [self parsingGallery];
}

-(void)parsingGallery
{
    [_galleryArr removeAllObjects];
 
    [_folderIdArr removeAllObjects];
    [_foldernameArr removeAllObjects];
    [_imgIdArr removeAllObjects];
    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:abc]];

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
    
    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/gallery.php";
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:gallery]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag": @"gallery_folder"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  circular data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"gallery_folder"];
            
            
            NSLog(@"ciculararr:%@",ciculararr);
            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"folder_name"]description];
                NSString *str2=[[temp objectForKey:@"folder_id"]description];
               NSString *str3=[[temp objectForKey:@"image_id"]description];
    
                NSLog(@"folder_name=%@  folder_id=%@",str1,str2);
          
                Gallery *k1=[[Gallery alloc]init];
                k1.foldernameStr=str1;
                k1.folderidStr=str2;
                k1.imageIdStr=str3;
               
           
                [_galleryArr addObject:k1];
                
                [_myCollectionView reloadData];
            }
            
        }
        [_myCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    return _galleryArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    GalleryCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Gallery *ktemp=[_galleryArr objectAtIndex:indexPath.row];
    
    cell.foldername.text=ktemp.foldernameStr;
    cell.folderid.text=ktemp.folderidStr;
    cell.imageid.text=ktemp.imageIdStr;
    
    
//   NSString *str = [@"http://erp.eshiksa.net/edemo_fees/esh/index.php?" stringByAppendingString:ktemp.imageIdStr];
//
//    NSString *urlstr=[str stringByAppendingFormat:@".png"];
//    NSLog(@"URL PATH=%@",urlstr);
    
    cell.galleryImgView.image=[UIImage imageNamed:@"galleryNew.png"];
    
  //  $instUrl."/esh/upload/images/gallery/".$images['image_id'].".png";
    //http://erp.eshiksa.net/edemo_fees/esh/upload/images/gallery/1694.png
    
    NSString *str1=[instUrl stringByAppendingString:@"/esh/upload/images/gallery/"];
    NSString *str = [str1 stringByAppendingString:ktemp.imageIdStr];
    NSString *urlstr=[str stringByAppendingFormat:@".png"];
    NSLog(@"URL PATH=%@",urlstr);
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:urlstr]]];
    
            dispatch_async(dispatch_get_main_queue(), ^{

                  cell.galleryImgView.image = img1;
                
            });
        });
   
    cell.contentView.layer.cornerRadius = 8.0;
    cell.contentView.layer.borderWidth = 1.0;
     cell.contentView.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor grayColor]);
    cell.contentView.layer.masksToBounds = true;
    
    
    return  cell;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    //    if(self.view.frame.size.width==768.0f)
//    //    {
//    //        return 10.0;
//    //    }
//    return 1.0;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 1.0;
//}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if(self.view.frame.size.height==1024.0f)
//    {
//        return CGSizeMake(206.0, 206.0);
//    }
//    if(self.view.frame.size.height==1366.0f)
//    {
//        return CGSizeMake(315.0, 260.0);
//    }
//    else
//    {
//        return CGSizeMake(103.0,73.0);
//    }
//    
//}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    GalleryCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Gallery *ktemp=[_galleryArr objectAtIndex:indexPath.row];
    cell.foldername.text=ktemp.foldernameStr;
    cell.folderid.text=ktemp.folderidStr;
    
    _folderIdStr=cell.folderid.text;
    
    _titleStr=cell.foldername.text;
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"in did select folder id=%@",cell.folderid.text);

    
    [self performSegueWithIdentifier:@"galleryDetails" sender:self];
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"galleryDetails"])
    {
        
        GalleryFolderVC *kvc = [segue destinationViewController];
        
        kvc.folderIdStr=_folderIdStr;
     
        kvc.indxpath=_indxp;
         NSLog(@"in prepare for segue folder id=%@",_folderIdStr);
        
    }
}
- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"GALLERY" localize];
}


@end
