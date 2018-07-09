//
//  Constant.m
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "Constant.h"

@implementation Constant

//NSString * const mainUrl = @"http://shop.eshiksa.com/appAPI_v2_edemo/";


//NSString * const auth = @"auth.php";
//NSString * const get_author_info = @"get_author_info.php";


+(void)executequery:(NSString *)strurl strpremeter:(id )parameter withblock:(void (^)(NSData *, NSError *))block{
    //SESSION CREATE
    NSURLSessionConfiguration *defaultconfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];//new session
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:defaultconfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];//queue is storing and retrieve data fifo
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strurl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    
    [request setHTTPMethod:@"POST"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * response, NSError * error) {
        if (data!=nil) {
            NSLog(@"Response %@",data);
            block(data,error);
        }
        else{
            NSLog(@"error");
            block(nil,error);
        }
    }];
    
    
    [task resume];
}
@end
