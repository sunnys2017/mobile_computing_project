//
//  AppDelegate.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "PassXML.h"
#import "NotificationStore.h"
#import "NotificationSet.h"
#import "mainViewController.h"
#import "tabBarMainController.h"
#import "UserCurrent.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


-(NSMutableArray *)getInfoFromWebServer:(NSString *) postnumber urlString:(NSString *)urlt method:(NSString *)method;

-(UILocalNotification*) setNotification:(NSDate *) datetime title:(NSString *) title;
-(NSString *)getGroupInfoFromWebServer:(NSString *) postnumber urlString:(NSString *)urlt method:(NSString *)method;

-(UserCurrent *)getCurrentUser;
@end
