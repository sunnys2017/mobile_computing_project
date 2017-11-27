//
//  notificationStore.m
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "NotificationStore.h"

@implementation NotificationStore

@synthesize _localNotification,_mark;

-(id) initWithLocalNotification:(UILocalNotification *) alocalNotification
                        andMark:(NSString *) amark{
    if(self==[super init]){
        _localNotification = alocalNotification;
        _mark = amark;
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *)coder
{

    [coder encodeObject: _localNotification forKey:@"_localNotification" ];

    [coder encodeObject: _mark forKey:@"_mark" ];

}

- (id) initWithCoder: (NSCoder *) coder
{

    UILocalNotification *l_localNotification = [coder decodeObjectForKey:@"_localNotification"];

    NSString *m_mark = [coder decodeObjectForKey:@"_mark" ];
    

    return [self initWithLocalNotification:l_localNotification andMark:m_mark];
}
@end
