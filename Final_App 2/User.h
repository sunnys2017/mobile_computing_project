//
//  User.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface User : NSObject{
    NSString * _userName;
    NSString * _password;
    NSString * _name;
    UIImage * _profile;
    NSString * _role;
    NSString * _groupNumber;

    sqlite3 * db;
    
}

@property (readwrite, retain)NSString * _userName;

@property (readwrite, retain)NSString * _password;

@property (readwrite, retain)NSString * _name;

@property (readwrite, retain)UIImage * _profile;

@property (readwrite, retain)NSString * _role;

@property (readwrite, retain)NSString * _groupNumber;

-(id)initWithUserName:(NSString *) auserName
          andPassword:(NSString *) apassword
              andName:(NSString *) aname
           andProfile:(UIImage *) aprofile
              andRole:(NSString *) arole
       andGroupNumber:(NSString *) agroupNumber;


-(NSMutableArray *) getDiaris:(NSString *)groupNumber;
-(NSString *) description;
-(void)InsertRecords:(NSString *)diaryTitle  :(NSString *)diaryBody   :(NSString *)date  :(NSString *)userName :(const char *) picX :(NSString *) diaryID ;

@end
