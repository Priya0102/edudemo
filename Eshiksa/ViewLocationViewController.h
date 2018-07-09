//
//  ViewLocationViewController.h
//  Eshiksa
//
//  Created by Punit on 09/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewLocationViewController : UIViewController<CLLocationManagerDelegate>
{
CLLocationManager *locationManager;
//    CLLocationManager *objLocationManager;
//     double latitude_UserLocation, longitude_UserLocation;
}
//@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end
