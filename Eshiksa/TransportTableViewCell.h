//
//  TransportTableViewCell.h
//  Eshiksa
//
//  Created by Punit on 14/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *viewMapBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *stopName;
@property (weak, nonatomic) IBOutlet UILabel *driverName;
@property (weak, nonatomic) IBOutlet UILabel *vehicleNumber;
@property (weak, nonatomic) IBOutlet UILabel *pickDropStatus;
@property (weak, nonatomic) IBOutlet UILabel *routeId;
@property (weak, nonatomic) IBOutlet UILabel *routeName;
@property (weak, nonatomic) IBOutlet UILabel *stopId;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet UILabel *journeyDetails;
@property (weak, nonatomic) IBOutlet UILabel *pickdropStatusLabel;

@end
