//
//  TransportViewController.m
//  Eshiksa
//
//  Created by Punit on 09/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//  <---api key
///AIzaSyDVrSY5_9yKSWkjfy1Wt2pD721oqhbRY5o

#import "TransportViewController.h"
#import "Transport.h"
#import "TransportTableViewCell.h"
#import "Constant.h"
#import "JourneyDetails.h"
#import "CurrentLocation.h"
#import "BaseViewController.h"
#import "Base.h"
@interface TransportViewController ()

@end

@implementation TransportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _transportArr=[[NSMutableArray alloc]init];
      _routeIdArr=[[NSMutableArray alloc]init];
      _routeNameArr=[[NSMutableArray alloc]init];
      _pickDropArr=[[NSMutableArray alloc]init];
    _stopIdArr=[[NSMutableArray alloc]init];
    _stopName=[[NSMutableArray alloc]init];
    _latitudeArr=[[NSMutableArray alloc]init];
    _longitudeArr=[[NSMutableArray alloc]init];
    _journeyDetailArr=[[NSMutableArray alloc]init];
    
    [self parsingTransportationData];
    
}
-(void)parsingTransportationData{
    
      [_transportArr removeAllObjects];
      [_routeIdArr removeAllObjects];
      [_routeNameArr removeAllObjects];
      [_pickDropArr removeAllObjects];
      [_stopIdArr removeAllObjects];
      [_stopName removeAllObjects];
      [_latitudeArr removeAllObjects];
      [_longitudeArr removeAllObjects];
      [_journeyDetailArr removeAllObjects];
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
   
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
 
    NSString *mystr=[NSString stringWithFormat:@"admission_no=%@&Branch_id=%@&tag=Stop_Route_list",username,branchid];
    
       NSLog(@"parameterDict%@",mystr);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    //NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:auth]];
    
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
                                          
                                          NSArray *routelist=[responseDict objectForKey:@"route_list"];
                                          
                                              NSLog(@"route_list:%@",routelist);
                                          
                                          if(routelist.count==0)
                                          {
                                              UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"No data available" preferredStyle:UIAlertControllerStyleAlert];
                                              
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
                                          
                                          for(NSDictionary *temp1 in routelist)
                                          {
                                              NSString *str1=[[temp1 objectForKey:@"route_id"]description];
                                              NSString *str2=[[temp1 objectForKey:@"route_name"]description];
                                              NSString *str3=[temp1 objectForKey:@"pick_drop"];
                                              NSString *str4=[temp1 objectForKey:@"stop_id"];
                                              NSString *str5=[[temp1 objectForKey:@"stop_name"]description];
                                              NSString *str6=[[temp1 objectForKey:@"latitude"]description];
                                              NSString *str7=[temp1 objectForKey:@"longitude"];
                                              NSString *str8=[temp1 objectForKey:@"journey_details"];
                                              
                                              
                                              NSLog(@"route_id=%@  route_name=%@ pick_drop=%@ stop_name=%@",str1,str2,str3,str5);
                                              [[NSUserDefaults standardUserDefaults] setObject:str5 forKey:@"stopname"];
                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                              
                                              
                                              Transport *k1=[[Transport alloc]init];
                                              k1.routeIdStr=str1;
                                              k1.routeNameStr=str2;
                                              k1.pickdropStatus=str3;
                                              k1.stopIdStr=str4;
                                              k1.stopNameStr=str5;
                                              k1.latitudeStr=str6;
                                              k1.longitudeStr=str7;
                                              k1.journeyDetailsStr=str8;
                                           
                            
                                              NSDictionary *dic=[temp1 objectForKey:@"journey_details"];
                                              
                                              //Transport *j=[[Transport alloc]init];
                                              
                                              k1.driverIdStr=[dic objectForKey:@"driver_id"];
                                              k1.driverNameStr=[dic objectForKey:@"driver_name"];
                                              k1.vehicleNumStr=[dic objectForKey:@"vechile_no"];
                                              k1.vehicleIdStr=[dic objectForKey:@"vechile_id"];
                                              k1.vehicleNameStr=[dic objectForKey:@"vechile_name"];
                                              k1.journeyIdStr=[dic objectForKey:@"journey_id"];
                                              k1.routeIdStr=[dic objectForKey:@"route_id"];
                                              k1.stopStr=[dic objectForKey:@"stops"];
                                              
                                             NSLog(@"driverNameStr:%@  vehicleNumStr:%@ stops%@",k1.driverNameStr,k1.vehicleNumStr,k1.stopStr);
                                              
                                              [_transportArr addObject:k1];
                                              
                                              [[NSUserDefaults standardUserDefaults] setObject:k1.journeyIdStr forKey:@"journeyid"];
                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                              
                                              NSArray *subarr=[temp1 objectForKey:@"stops"];
                                              
                                              NSLog(@"****stops arr:%@",subarr);
                                              
                                              for(NSDictionary *temp in subarr)
                                              {
                                                  NSString *str1=[[temp objectForKey:@"Branch_id"]description];
                                                  NSString *str2=[[temp objectForKey:@"stop_id"]description];
                                                  NSString *str3=[[temp objectForKey:@"route_id"]description];
                                                  NSString *str4=[[temp objectForKey:@"stop_name"]description];
                                                  NSString *str5=[[temp objectForKey:@"lankmark"]description];
                                                  NSString *str6=[[temp objectForKey:@"landmark_address"]description];
                                                  NSString *str7=[[temp objectForKey:@"lat"]description];
                                                  NSString *str8=[[temp objectForKey:@"landmark_lat"]description];
                                                  NSString *str9=[[temp objectForKey:@"lng"]description];
                                                  NSString *str10=[[temp objectForKey:@"landmark_lng"]description];
                                                  NSString *str11=[[temp objectForKey:@"view_order"]description];
                                                  NSString *str12=[[temp objectForKey:@"fees_amount"]description];
                                                  NSString *str13=[[temp objectForKey:@"created_date"]description];
                                                  NSString *str14=[[temp objectForKey:@"status"]description];
                                                  NSString *str15=[[temp objectForKey:@"opyear"]description];
                                                  NSString *str16=[[temp objectForKey:@"org_id"]description];
                                                  NSString *str17=[[temp objectForKey:@"address"]description];
                                                   NSString *str18=[[temp objectForKey:@"pincode"]description];
                                                  
                                                  NSLog(@"Branch_id=%@  stop_id=%@ stop_name=%@ route_id=%@ landmark=%@ landmark_address=%@  lat=%@ landmark_lat=%@ lng=%@ landmark_lng=%@ view_order=%@  fees_amount=%@ created_date=%@ status=%@ opyear=%@ org_id=%@ address=%@ pincode=%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18);
                                          }
                                          }
                                          }
                                          [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                      }];
      [dataTask resume];
  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _transportArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransportTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Transport *ktemp=[_transportArr objectAtIndex:indexPath.row];
    
    cell.stopName.text=ktemp.stopNameStr;
    cell.pickDropStatus.text=ktemp.pickdropStatus;
    cell.vehicleNumber.text=ktemp.vehicleNumStr;
    cell.driverName.text=ktemp.driverNameStr;

    
    [cell.viewMapBtn addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([cell.pickDropStatus.text isEqualToString:@"1"])
    {
        cell.pickdropStatusLabel.text=@"On going";
        cell.statusLbl.text=@"Pick Up";
       
    }
    else
    {
        cell.pickdropStatusLabel.text=@"Not Started yet";
        cell.statusLbl.text=@"Drop";
       
    }
    
    return cell;
}

-(void)buttonclicked:(id)sender
{
    NSLog(@"view map button clicked.....");

    NSString *stopname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"stopname"];
    NSLog(@"stopname ==%@",stopname);

    NSString *longitude = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"longitude"];
    NSLog(@"longitude ==%@",longitude);

    NSString *latitude = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"latitude"];
    NSLog(@"latitude ==%@",latitude);

    NSString *journeyid = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"journeyid"];
    NSLog(@"btn clicked journeyid ==%@",journeyid);

  [self getCurrentRouteList];
}
-(void)getCurrentRouteList{
    
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
                                         
                                         
            NSLog(@"in transport driverIdStr==%@ longitudeStr ==%@",c.driverIdStr,c.longitudeStr);
                                         
                    [[NSUserDefaults standardUserDefaults] setObject:c.longitudeStr forKey:@"longitude"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                                         
                    [[NSUserDefaults standardUserDefaults] setObject:c.latitudeStr forKey:@"latitude"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                                         
//                    [[NSUserDefaults standardUserDefaults] setObject:c.journeyIdStr forKey:@"journeyid"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
                                
    }];
                                     
     [dataTask resume];
                           
}

- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"TRANSPORT_ROUTE" localize];
}
@end
