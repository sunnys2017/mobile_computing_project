//
//  MyPost.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "Post.h"

@implementation Post

@synthesize  _postTitle, _postBody, _postComments,_postImage,_postDate,_postID,_userName,_name,_groupNumber;

-(id)initWithPostTitle:(NSString *) apostTitle
           andPostBody:(NSString *) apostBody
          andPostImage:(NSString *) aimage
        andPostComment:(NSMutableArray *) acomments
           andPostDate:(NSString *) adate
             andPostID:(NSString *) apostID
           andUserName:(NSString *) auserName
               andName:(NSString *) aname
        andGroupNumber:(NSString *)agroupNumber{
    if(self==[super init]){
        _postTitle = apostTitle;
        _postBody = apostBody;
        _postComments = acomments;
        _postImage = aimage;
        _postDate = adate;
        _postID = apostID;
        _userName = auserName;
        _name = aname;
        _groupNumber=agroupNumber;
    }
    return self;
}

-(NSString *) description{
    return [NSString stringWithFormat: @"%@,%@,%@,%@,%@,%@,%@\n",_postTitle,_postBody,_postImage,_postDate,_name,_groupNumber,_userName];
}

@end
