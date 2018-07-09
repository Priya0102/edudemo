//
//  ViewLocationViewController.m
//  Eshiksa
//
//  Created by Punit on 09/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//GMSCameraPosition *camera=[GMSCameraPosition cameraWithLatitude:21.1450677 longitude:79.0889168 zoom:14 bearing:0 viewingAngle:0];
//https://stackoverflow.com/questions/13433234/sending-nsnumber-strong-to-parameter-of-incompatible-type-cllocationdegree/13433261

#import "ViewLocationViewController.h"
#import "CurrentLocation.h"
#import <GoogleMaps/GoogleMaps.h>
#import "UIKit/UIKit.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ViewLocationViewController ()
{
    NSTimer *timer;
}
@property(strong,nonatomic) GMSMapView *mapView;
@end

@implementation ViewLocationViewController
@synthesize mapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *stopname = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"stopname"];
    NSLog(@"stopname ==%@",stopname);
    
    NSString *longitudestr = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"longitude"];
    NSLog(@"longitude ==%@",longitudestr);
    
    NSString *latittudestr = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"latitude"];
    NSLog(@"latitude ==%@",latittudestr);
    
    NSString *journeyId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"journeyid"];
    NSLog(@"journeyId ==%@",journeyId);
    
    if (journeyId.length==0) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Journey not started yet" preferredStyle:UIAlertControllerStyleAlert];
        
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

    GMSCameraPosition *camera=[GMSCameraPosition cameraWithLatitude:21.1450677 longitude:79.0889168 zoom:14 bearing:0 viewingAngle:0];
   // GMSCameraPosition *camera=[GMSCameraPosition cameraWithLatitude:latitudestr longitude:longit zoom:14];

    self.mapView=[GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    self.mapView.mapType=kGMSTypeNormal;
    //self.mapView.myLocationEnabled=YES;//to find current location
    self.mapView.settings.compassButton=YES;
    self.mapView.settings.myLocationButton=YES;
    [self.mapView setMinZoom:10 maxZoom:18];
    
    [self.view addSubview:self.mapView];
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       GMSMarker *marker=[[GMSMarker alloc]init];
                       //marker.position=CLLocationCoordinate2DMake(latitude,longitude);
                       marker.position=CLLocationCoordinate2DMake(21.1450677,79.0889168);
                       marker.map=self.mapView;
                       marker.title=@"Nagpur";
                       marker.snippet=stopname;
                       marker.appearAnimation=kGMSMarkerAnimationPop;
                       // marker.icon=[GMSMarker markerImageWithColor:[UIColor redColor]];
                       marker.icon=[UIImage imageNamed:@"map_car_running.png"];
                       
                   });
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
   
     //[self getCurrentRouteList];
    
    if (timer==nil) {
        timer=[NSTimer scheduledTimerWithTimeInterval:0.1 repeats:true block:^(NSTimer * _Nonnull timer) {
            
        }];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Turn off the location manager to save power.
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}
-(BOOL)prefersStatusBarHidden{
    return  YES;
}


/*-(void)getCurrentRouteList{
    
    NSString *journeyid = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"journeyid"];
    NSLog(@"circular journeyid ==%@",journeyid);
    
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *mystr=[NSString stringWithFormat:@"journey_id=%@&Branch_id=%@&tag=Current_Location_of_Vehicle",journeyid,branchid];
    
    NSLog(@"parameterDict in currnt route list%@",mystr);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://erp.eshiksa.net/edemo_fees/esh/plugins/APIS/currentroutelist.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[mystr dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
    }
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                     {
                                         if(error)
                                         {
                                         }
                                         
                                         NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                         NSError *er=nil;
                                         NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
                                         if(er)
                                         {
                                         }
                                         NSLog(@"responseDict:%@",responseDict);
                                         
                                         NSDictionary *dic=[responseDict objectForKey:@"location"];
                                         NSLog(@"location dic%@",dic);
                                         
                                         
                                         CurrentLocation *c=[[CurrentLocation alloc]init];
                                         
                                         c.driverIdStr=[dic objectForKey:@"driver_id"];
                                         c.busIdStr=[dic objectForKey:@"bus_id"];
                                         c.cdatetimeStr=[dic objectForKey:@"cdatetime"];
                                         c.latitudeStr=[dic objectForKey:@"latetude"];
                                         c.longitudeStr=[dic objectForKey:@"longitude"];
                                         c.angleStr=[dic objectForKey:@"angle"];
                                         c.opyearStr=[dic objectForKey:@"opyear"];
                                         c.journeyIdStr=[dic objectForKey:@"journey_id"];
                                         
                                         
                                         //            _descriptionCircular.text=c.circularDetailStr;
                                         //            _cir_file.text=c.cirFlieStr;
                                         
                                         NSLog(@"driverIdStr==%@ longitudeStr ==%@",c.driverIdStr,c.longitudeStr);
                                         
                                         [[NSUserDefaults standardUserDefaults] setObject:c.longitudeStr forKey:@"longitude"];
                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                         
                                         [[NSUserDefaults standardUserDefaults] setObject:c.latitudeStr forKey:@"latitude"];
                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                         
                                         [[NSUserDefaults standardUserDefaults] setObject:c.journeyIdStr forKey:@"journeyId"];
                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                         
                                     }];
    
    [dataTask resume];
    
}
*/

@end
