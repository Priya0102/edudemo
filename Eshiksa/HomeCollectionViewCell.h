//
//  HomeCollectionViewCell.h
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UIImageView *patternImageView;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end
