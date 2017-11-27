//
//  newsViewController.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AppDelegate.h"
#import "Post.h"
#import "UserCurrent.h"

@interface newsViewController : UITableViewController{
    NSMutableArray * _newsArray;
    NSMutableArray * _postsArray;
    
}
@property (nonatomic,retain) NSMutableArray * _newsArray;
@property (nonatomic,retain) NSMutableArray * _postsArray;
@property (nonatomic, strong) NSArray *colors;

-(void)viewWillAppear:(BOOL)animated;
-(Post *) getSpecificPost:(NSString *)postID;
-(NSMutableArray *)getPostsArray;
@end
