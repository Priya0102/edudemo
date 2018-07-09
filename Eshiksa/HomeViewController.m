//
//  HomeViewController.m
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView:self.scroll];
    
    UIPageControl *pgCtr=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 264, 480, 36)];
    [pgCtr setTag:12];
    pgCtr.numberOfPages=3;
    pgCtr.autoresizingMask=UIViewAutoresizingNone;
    [self.contentview addSubview:pgCtr];
    self.patternImagesArray=@[@"1.png",@"2.png",@"3.png",@"attendance.png",@"circulars.png",@"gallery.png"];
    
    self.labelArray=@[@"Profile",@"Circulars",@"Gallery",@"Attendance",@"Timetable",@"Settings"];
}


-(void)setupScrollView:(UIScrollView *)scrMain{
    for (int i=1; i<=3; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"img1.jpg"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"img2.jpg"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"img3.png"]];
       

        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake((i-1)*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)];
        //  UIImageView *imgView=[[UIImageView alloc]init];
        
        imgView.contentMode=UIViewContentModeScaleToFill;
        [imgView setImage:image];
        imgView.animationImages=@[image,image2,image3];
        imgView.animationDuration=8.0;
        imgView.tag=i+1;
        [scrMain addSubview:imgView];
        [imgView startAnimating];
    }
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*10, scrMain.frame.size.height)];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}

-(void)scrollingTimer{
    //UIScrollView *scrMain=(UIScrollView *)[self.view viewWithTag:1];
    UIPageControl *pgCtr=(UIPageControl*)[self.view viewWithTag:12];
    CGFloat contentOffset=self.scroll.contentOffset.x;
    
    
    int nextPage=(int)(contentOffset/self.scroll.frame.size.width)+1;
    
    if (nextPage!=4){
        [self.scroll scrollRectToVisible:CGRectMake(nextPage*self.scroll.frame.size.width,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        pgCtr.currentPage=nextPage;
    }else{
        [self.scroll scrollRectToVisible:CGRectMake(0,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        
        pgCtr.currentPage=0;
    }

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.patternImagesArray count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Pattern Cell" forIndexPath:indexPath];
   NSString *myPatternString=[self.patternImagesArray objectAtIndex:indexPath.row];
    cell.patternImageView.image=[UIImage imageNamed:myPatternString];
    cell.name.text=self.labelArray[indexPath.row];
    return  cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(103,73);
    //return CGSizeMake(self.myCollectionView.window.bounds.size.width/2,self.myCollectionView.window.bounds.size.height/3);
    
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
