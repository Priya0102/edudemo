//
//  DBManager.h
//  Eshiksa
//
//  Created by Punit on 22/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBManager : NSObject{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)userid username:(NSString*)username
      password:(NSString*)password orgtype:(NSString*)orgtype;

-(NSArray*) findByRegisterNumber:(NSString*)userid;


@end
