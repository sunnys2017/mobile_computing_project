//
//  MyPost.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject{
    NSString * _postTitle;
    NSString * _postBody;
    NSString * _postImage;
    NSMutableArray * _postComments;
    NSString * _postDate;
    NSString * _postID;
    NSString * _userName;
    NSString * _name;
    NSString * _groupNumber;
}

@property (readwrite, retain) NSString * _postTitle;

@property (readwrite, retain) NSString * _postBody;

@property (readwrite, retain) NSString * _postImage;

@property (readwrite, retain)  NSMutableArray * _postComments;

@property (readwrite, retain)  NSString * _postDate;

@property (readwrite, retain)  NSString * _postID;

@property (readwrite, retain)  NSString * _userName;

@property (readwrite, retain)  NSString * _name;
@property (readwrite, retain)  NSString * _groupNumber;

-(id)initWithPostTitle:(NSString *) apostTitle
           andPostBody:(NSString *) apostBody
          andPostImage:(NSString *) aimage
        andPostComment:(NSMutableArray *) acomments
           andPostDate:(NSString *) adate
             andPostID:(NSString *) apostID
           andUserName:(NSString *) auserName
               andName:(NSString *) aname
        andGroupNumber:(NSString *) agroupNumber;
@end
