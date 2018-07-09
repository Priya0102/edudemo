//
//  HomeViewController.h
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSString *result;

@property(nonatomic,strong)NSArray *patternImagesArray;
@property (weak, nonatomic) IBOutlet UILabel *message;

@property(nonatomic,strong)NSArray *labelArray;
@property (weak, nonatomic) IBOutlet UIImageView *animationView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (strong,nonatomic) NSString *role_id;
@end
