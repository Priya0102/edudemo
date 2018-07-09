//
//  FetchSchool.h
//  Eshiksa
//
//  Created by Punit on 08/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchSchool : NSObject

@property(nonatomic,retain)NSString *firstNameStr,*lastNameStr,*rollNumStr,*studentIdStr,*fullNameStr,*attendanceStatusStr;
-(id)initWithCode:(NSString *)code_
             firstNameStr:(NSString *)firstNameStr
        lastNameStr:(NSString *)lastNameStr
       rollNumStr:(NSNumber *)rollNumStr;

- (NSMutableDictionary *)toNSDictionary;

@end
