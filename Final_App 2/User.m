//
//  User.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "User.h"
#import "Diary.h"

@implementation User
    NSFileManager * fileMgr;

    NSString * title;


@synthesize _userName,_password,_name,_profile,_role,_groupNumber;


-(id)initWithUserName:(NSString *) auserName
          andPassword:(NSString *) apassword
              andName:(NSString *) aname
           andProfile:(UIImage *) aprofile
              andRole:(NSString *)arole
       andGroupNumber:(NSString *) agroupNumber{
    if(self==[super init]){
        _userName = auserName;
        _password = apassword;
        _name = aname;
        _profile = aprofile;
        _role = arole;
        _groupNumber = agroupNumber;
    }
    return self;
}

-(NSMutableArray *) getDiaris:(NSString *)userName{
    NSMutableArray * groupPostArray = [[NSMutableArray alloc] init];
    @try {
        //NSFileManager * fileMgr = [NSFileManager defaultManager];
        
        NSString * dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"finaldatabase.sqlite"];
        
        
        if (!sqlite3_open([dbPath UTF8String],&db) ==SQLITE_OK) {
            NSLog(@"An error has occured.");
        }
 
        NSString *insertSQL = [NSString stringWithFormat: @"SELECT diaryTitle, diaryBody, date,pic,userName,diaryID FROM Diary WHERE userName = \"%@\"",userName];
        const char *sql = [insertSQL UTF8String];
        
        
        //const char * sql = "SELECT postTitle, postBody, postDate,postID,userName,name FROM MyPost WHERE groupNumber = \"%@\"";
        sqlite3_stmt * sqlStatement;
        
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL)!= SQLITE_OK){
            NSLog(@"Problem with prepare statement");
        }
        //
        while (sqlite3_step(sqlStatement)==SQLITE_ROW){
            Diary * _diary = [[Diary alloc] init];
            _diary._diaryTitle =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
            _diary._diaryBody =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            _diary._date =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            //_diary._pic =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            
             const char * raw = sqlite3_column_blob(sqlStatement, 3);
             int rawLen = sqlite3_column_bytes(sqlStatement, 3);
             NSData * data = [NSData dataWithBytes:raw length:rawLen];
             _diary._pic = [[UIImage alloc] initWithData:data];
            
            _diary._userName =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
            _diary._diaryID =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];



            [groupPostArray addObject:(Diary *)_diary];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return groupPostArray;
    }
   
}

-(NSString *) description{
    return [NSString stringWithFormat: @"%@,%@,%@,%@,%@\n",_userName,_password,_name,_groupNumber,_role];
}






-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    NSString * homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    return homeDir;
}

-(void)CopyDbToDocumentsFolder{
    NSError *err=nil;
    
    fileMgr = [NSFileManager defaultManager];
    
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"finaldatabase.sqlite"];
    
    NSString *copydbpath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"finaldatabase.sqlite"];
    
    [fileMgr removeItemAtPath:copydbpath error:&err];
    if(![fileMgr copyItemAtPath:dbpath toPath:copydbpath error:&err])
    {
        UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:title message:@"Unable to copy database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [tellErr show];
    }
}
-(void)InsertRecords:(NSString *)diaryTitle  :(NSString *)diaryBody   :(NSString *)date  :(NSString *)userName :(const char *) picX :(NSString *) diaryID {
    
    fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *stmt;
    sqlite3 * dbb;
    

    NSString *dataPath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"finaldatabase.sqlite"];
    
    const char * pic=[[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[diaryID stringByAppendingString:@".jpg"]]UTF8String];
    
    sqlite3_open([dataPath UTF8String], &dbb);
    
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO Diary (diaryTitle, diaryBody, date,pic,userName,diaryID) VALUES (\"%@\",\"%@\",\"%@\", \"%s\", \"%@\", \"%@\")", diaryTitle,diaryBody,date,pic,userName,diaryID];
    const char *sql = [insertSQL UTF8String];
    sqlite3_prepare_v2(dbb, sql,-1,&stmt, nil);
    
    
    if (sqlite3_step(stmt) == SQLITE_DONE) {
		NSLog(@"Contact added");
	} else {
 		NSLog(@"Failed to add contact");
 	}
    
    sqlite3_finalize(stmt);
    sqlite3_close(dbb);
    //[self getSpecificItem:_itemNameX];
}


@end
