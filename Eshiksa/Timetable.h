//
//  Timetable.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timetable : NSObject

@property (nonatomic,strong) NSString *lectureTimingStr,*lectureNameStr,*subjectnameStr,*subjectIdStr,*dayStr,*teacherNameStr,*breakStr;
@property (strong,nonatomic) NSString *day;
@end
