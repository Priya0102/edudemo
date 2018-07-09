//
//  Constant.h
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

//extern NSString * const mainUrl;
//
//extern NSString * const auth;
//extern NSString * const get_author_info;

+(void)executequery:(NSString *)strurl strpremeter:(NSString*)premeter withblock:(void(^)(NSData *,NSError*))block;
//globally it can be accessed & execute query is argument name and type object name

@end
