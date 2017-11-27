//
//  AppDelegate.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


NSFileManager * fileMgr;
NSString * title;
PassXML * p;
NSMutableArray * newsArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //[self getInfoFromWebServer:@"1" urlString:@"post" method:nil];
    //[self getInfoFromWebServer:@"ID" urlString:@"comment" method:nil];
    //[self getInfoFromWebServer:@"s" urlString:@"authenticate" method:nil];
    /*
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController ;
    
    UIViewController * C =[[tabBarController viewControllers]objectAtIndex:0];
    mainViewController *loginViewController = [[mainViewController alloc] init];
    
    [C presentModalViewController:loginViewController animated:NO];
*/
    
    // Override point for customization after application launch.
    NSString *copydbpath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"finaldatabase.sqlite"];
    fileMgr = [NSFileManager defaultManager];
    if(![fileMgr fileExistsAtPath:copydbpath]){
        [self CopyDbToDocumentsFolder];
    }
    
    //add notification
    UILocalNotification * notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(notification){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:notification.alertBody delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    
    return YES;
}

-(id)getInfoFromWebServer:(NSString *) postnumber urlString:(NSString *)urlt method:(NSString *)method {
    NSString * urltemp = @"http://localhost:8080/final_app/";
    NSString * urltemp1 = [urltemp stringByAppendingString:urlt];
    
    NSURL * url = [NSURL URLWithString:urltemp1];
    NSMutableURLRequest * request = [NSMutableURLRequest new ];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    NSString * ss = @"id=";
    NSString * groupID = [ss stringByAppendingString:postnumber];
    [request setHTTPBody:[NSData dataWithBytes: [groupID UTF8String] length:[groupID length]]];
    
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data == nil){
        NSString * S =@"nothing here";
        NSLog(@"%@",S);
    }
    NSString * result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //NSLog(@"%@", result);
    NSMutableArray * _order =[[NSMutableArray alloc] init];

    if([urlt isEqualToString:@"post"]){
        if([result isEqualToString:@""]){
            return _order;
        }
        NSArray *listItems = [result componentsSeparatedByString:@"##"];
        for(NSString* obj in listItems){
            if(![obj isEqualToString:@""]){
                
                Post * com = [[Post alloc ] init];
                NSArray *lists = [obj componentsSeparatedByString:@"<>"];
                com._postTitle = [lists objectAtIndex:0];
        
                com._postTitle = [self selectCharacter:com._postTitle];
                
                com._postBody = [lists objectAtIndex:1];
                
                com._postBody=[self selectCharacter:com._postBody];
                
                com._postDate =  [lists objectAtIndex:2];
                com._postID =  [lists objectAtIndex:3];
                com._userName =  [lists objectAtIndex:4];
                com._name =  [lists objectAtIndex:5];
                com._postImage =  [lists objectAtIndex:6];
                com._groupNumber =  [lists objectAtIndex:7];
                [_order addObject:com];
            }
            
        }
    }else if([urlt isEqualToString:@"comment"]){
        if([result isEqualToString:@""]){
            return _order;
        }
        NSArray *listItems = [result componentsSeparatedByString:@"##"];
        for(NSString* obj in listItems){
            if(![obj isEqualToString:@""]){
                Comment * com = [[Comment alloc ] init];
                NSArray *lists = [obj componentsSeparatedByString:@"<>"];
                com._commentBody = [lists objectAtIndex:0];
                
                com._commentBody=[self selectCharacter:com._commentBody];
                
                com._commentDate = [lists objectAtIndex:3];
                com._commentID =  [lists objectAtIndex:2];
                com._name =  [lists objectAtIndex:5];
                com._postID =  [lists objectAtIndex:1];
                com._userName =  [lists objectAtIndex:4];
                [_order addObject:com];
            }
            
        }
        
    }else if([urlt isEqualToString:@"authenticate"]){
        if([result isEqualToString:@""]){
            return _order;
        }
        
        NSArray *listItems = [result componentsSeparatedByString:@"##"];

        User * user = [[User alloc] init];
        NSArray *lists = [[listItems objectAtIndex:0] componentsSeparatedByString:@"<>"];
        user._userName = [lists objectAtIndex:0];
        user._password = [lists objectAtIndex:1];
        user._name = [lists objectAtIndex:2];
        user._profile = [lists objectAtIndex:3];
        user._role = [lists objectAtIndex:4];
        user._groupNumber = [lists objectAtIndex:5];
        [_order addObject:user];
        NSLog(@"%@",user.description);

    }
    

    return _order;
}

-(NSString *)selectCharacter:(NSString *)string{
    NSString * tempBody = @"";
    NSArray *postBodyLists = [string componentsSeparatedByString:@"+"];
    for(int i = 0 ; i< postBodyLists.count;i++){
        tempBody=[tempBody stringByAppendingString:[[postBodyLists objectAtIndex:i] stringByAppendingString:@" "]];
    }
    return tempBody;
    
}

-(NSString *)getGroupInfoFromWebServer:(NSString *) postnumber urlString:(NSString *)urlt method:(NSString *)method {
    NSString * urltemp = @"http://localhost:8080/final_app/";
    NSString * urltemp1 = [urltemp stringByAppendingString:urlt];
    
    NSURL * url = [NSURL URLWithString:urltemp1];
    NSMutableURLRequest * request = [NSMutableURLRequest new ];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    NSString * ss = @"id=";
    NSString * groupID = [ss stringByAppendingString:postnumber];
    [request setHTTPBody:[NSData dataWithBytes: [groupID UTF8String] length:[groupID length]]];
    
    NSURLResponse * response;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data == nil){
        NSString * S =@"nothing here";
        NSLog(@"%@",S);
    }
    NSString * result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@", result);
    return result;
}





-(NSString *)GetDocumentDirectory{
    
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

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // NOTIFICATION
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Notification_" message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(UserCurrent *)getCurrentUser{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return userCur;
}

-(UILocalNotification*) setNotification:(NSDate *) datetime title:(NSString *) title{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //Format the date
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    
    localNotification.fireDate = datetime;
    localNotification.alertBody = [NSString stringWithFormat:@"Your task %@ at %@ is now",title, [dateFormatter stringFromDate:datetime]];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    //keep track of the notification
    NotificationStore * not = [[NotificationStore alloc]init];
    not._localNotification = localNotification;
    not._mark =[title stringByAppendingString:[dateFormatter stringFromDate:datetime]];
    
    //store notice
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/notice.txt"];
    NSArray *myNoticeList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (myNoticeList==nil) {
  
        NSMutableArray * tempArray = [[NSMutableArray alloc]init];
        [tempArray addObject:not];
        NotificationSet * noticeSet =
        [[NotificationSet alloc] initWithNoticeArray:tempArray];
        [NSKeyedArchiver archiveRootObject: noticeSet toFile:(NSString *)path];
        
    }else{
        NotificationSet * noticeSet=[NSKeyedUnarchiver unarchiveObjectWithFile:(NSString *)path];
        [[noticeSet _noticeArray] addObject:not];
        [NSKeyedArchiver archiveRootObject: noticeSet toFile:(NSString *)path];
    }

    return localNotification;
}

@end
