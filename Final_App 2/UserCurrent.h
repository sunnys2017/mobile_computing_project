//
//  UserCurrent.h
//  Final_App
//
//  Created by Yeming on 4/24/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserCurrent : NSObject{

    NSString * _userName;
    NSString * _password;
    NSString * _name;
    UIImage * _profile;
    NSString * _role;
    NSString * _groupNumber;
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


- (void) encodeWithCoder: (NSCoder *)coder;
- (id) initWithCoder: (NSCoder *) coder;
@end
