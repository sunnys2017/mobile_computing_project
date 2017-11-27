//
//  Group.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject{
    NSString * _groupNumber;
    NSMutableArray * _groupMembers;
    NSString * _groupID;
}


@property (readwrite, retain) NSString * _groupNumber;
@property (readwrite, retain) NSMutableArray * _groupMembers;
@property (readwrite, retain) NSString * _groupID;

-(id)initWithGroupNumber:(NSString *) agroupNumber
         andGroupMembers:(NSMutableArray *) agroupMembers
              andGroupID:(NSString *) agroupID;

@end
