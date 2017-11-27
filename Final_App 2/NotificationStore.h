//
//  notificationStore.h
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationStore : NSObject{
    UILocalNotification * _localNotification ;
    NSString * _mark;
}

@property (nonatomic, retain) UILocalNotification * _localNotification ;
@property (nonatomic, retain) NSString * _mark;


-(id) initWithLocalNotification:(UILocalNotification *) alocalNotification
                        andMark:(NSString *) amark;
- (void) encodeWithCoder: (NSCoder *)coder;
- (id) initWithCoder: (NSCoder *) coder;
@end
