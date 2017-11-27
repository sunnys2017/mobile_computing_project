//
//  NotificationSet.m
//  Final_App
//
//  Created by Yeming on 4/22/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "NotificationSet.h"

@implementation NotificationSet

@synthesize _noticeArray;


-(id)initWithNoticeArray:(NSMutableArray *) anoticeArray{
    if(self == [super init]){
        _noticeArray = anoticeArray;
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    
    [coder encodeObject: _noticeArray forKey:@"_noticeArray" ];
    
}

- (id) initWithCoder: (NSCoder *) coder
{
    
    NSMutableArray *n_noticeArray = [coder decodeObjectForKey:@"_noticeArray"];
    
    
    return [self initWithNoticeArray:n_noticeArray];
}

@end
