//
//  DBManager.m
//  Eshiksa
//
//  Created by Punit on 22/06/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//
#import "DBManager.h"
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent:@"student.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt ="create table if not exists studentsDetail (userid integer primary key, username text, password text, orgtype text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        } else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}
- (BOOL) saveData:(NSString*)userid username:(NSString *)username password:(NSString *)password orgtype:(NSString *)orgtype{
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (userid,username, password,orgtype) values(\"%ld\",\"%@\", \"%@\", \"%@\")",[userid integerValue],username, password, orgtype];
                                const char *insert_stmt = [insertSQL UTF8String];
                                sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
                                
                                if (sqlite3_step(statement) == SQLITE_DONE) {
                                    return YES;
                                } else {
                                    return NO;
                                }
                              //  sqlite3_reset(statement);
                                }
                    return NO;
}

- (NSArray*) findByRegisterNumber:(NSString*)userid {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"select username, password, orgtype from studentsDetail where userid=\"%@\"",userid];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *username = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:username];
                NSString *password = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:password];
                NSString *orgtype = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:orgtype];
                return resultArray;
            } else {
                NSLog(@"Not found");
                return nil;
            }
           // sqlite3_reset(statement);
        }
    }
    return nil;
}
@end
