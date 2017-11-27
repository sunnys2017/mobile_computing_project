//
//  Group.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize _groupMembers,_groupNumber,_groupID;

-(id)initWithGroupNumber:(NSString *) agroupNumber
         andGroupMembers:(NSMutableArray *) agroupMembers
              andGroupID:(NSString *) agroupID{
    if(self==[super init]){
        _groupMembers =agroupMembers;
        _groupNumber =agroupNumber;
        _groupID = agroupID;
    }
    return self;
}

@end
