#import "GalleryDetailViewController.h"
#import "GalleryDetailsCollectionViewCell.h"
#import "WebViewController.h"
#import "GalleryDetails.h"
#import "Constant.h"
#import "Base.h"
@interface GalleryDetailViewController ()
@property NSMutableArray *imageArray;

@end

@implementation GalleryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *folderid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"folderid"];
    NSLog(@"** folderid ==%@",folderid);
    
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    
    [self parsingGallery];
   
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString: [self.imageArray objectAtIndex:indexPath.row]];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       
                    dispatch_sync(dispatch_get_main_queue(), ^{
                           //If self.image is atomic (not declared with nonatomic)
                           // you could have set it directly above
                           cell.images.image = [UIImage imageWithData:imageData];
                           cell.subfolderName.text = [NSURL URLWithString: [self.imageArray objectAtIndex:indexPath.row]].lastPathComponent;
                           //This needs to be set here now that the image is downloaded
                           // and you are back on the main thread
                       });
                   });
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.imageArray.count;
}
-(void)parsingGallery
{
    
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_galleryArr removeAllObjects];
    [_imgArr removeAllObjects];
    
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
    
    NSString *folderid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"folderid"];
    NSLog(@"** folderid in api ==%@",folderid);
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:gallery]];
    
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"folder_id":folderid,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag":@"gallery_images"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  gallery data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[maindic objectForKey:@"success"];
            _error=[maindic objectForKey:@"error"];
            
            NSDictionary *dic=[maindic objectForKey:@"gallery"];
            
            NSArray *imageArr=[dic objectForKey:@"images"];
            
            NSLog(@"****images arr:%@",imageArr);
            
            if(imageArr.count==0)
            {
                
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"No Images available" preferredStyle:UIAlertControllerStyleAlert];
                
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
            else {
        
                NSArray *images = [dic objectForKey:@"images"];
                
                self.imageArray = [[NSMutableArray alloc]init];
                for (NSString *url in images) {
                    
                    NSLog(@"url :::: %@", url);
                    [self.imageArray addObject:url];
                    
                }
                
                [_myCollectionView reloadData];
            }
        }
        [_myCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GalleryDetailsCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"indexpath==%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"showImgDownload"
                              sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showImgDownload"]) {
        
        
        // wvc.myURL=_videosArray;
        
        //NSLog(@"*******full showVideoDownload url str=%@",videoresult);
        
        
    }
}

@end
