//
//  FetchSchool.m
//  Eshiksa
//
//  Created by Punit on 08/06/18.


#import "FetchSchool.h"

@implementation FetchSchool

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {

        self.firstNameStr = dictionary[@"first_name"];
        self.lastNameStr = dictionary[@"last_name"];
        self.rollNumStr = dictionary[@"class_roll_no"];
        self.attendanceStatusStr = dictionary[@"status"];
        self.studentIdStr = dictionary[@"student_id"];

    }
    return self;
}

@end
