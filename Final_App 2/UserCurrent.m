//
//  UserCurrent.m
//  Final_App
//
//  Created by Yeming on 4/24/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "UserCurrent.h"

@implementation UserCurrent

@synthesize _groupNumber,_name,_userName,_password,_profile,_role;
 
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

- (void) encodeWithCoder: (NSCoder *)coder
{
    
    [coder encodeObject: _userName forKey:@"_userName" ];
    [coder encodeObject: _password forKey:@"_password" ];
    [coder encodeObject: _name forKey:@"_name" ];
    [coder encodeObject: _groupNumber forKey:@"_groupNumber" ];
    [coder encodeObject: _role forKey:@"_role" ];
    [coder encodeObject: _profile forKey:@"_profile" ];
    
}

- (id) initWithCoder: (NSCoder *) coder
{
    
    NSString *u_userName = [coder decodeObjectForKey:@"_userName"];
    NSString *p_password = [coder decodeObjectForKey:@"_password"];
    NSString *n_name = [coder decodeObjectForKey:@"_name"];
    NSString *g_groupNumber = [coder decodeObjectForKey:@"_groupNumber"];
    NSString *r_role = [coder decodeObjectForKey:@"_role"];
    UIImage *p_profile = [coder decodeObjectForKey:@"_profile"];
    
    
    return [self initWithUserName:u_userName andPassword:p_password andName:n_name andProfile:p_profile andRole:r_role andGroupNumber:g_groupNumber];
}
@end
