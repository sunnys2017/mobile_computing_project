//
//  Comment.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject{
    NSString * _commentBody;
    NSString * _postID;
    NSString * _commentDate;
    NSString * _commentID;
    NSString * _userName;
    NSString * _name;
    
}
@property (retain,readwrite) NSString * _commentBody;
@property (retain,readwrite) NSString * _postID;
@property (retain,readwrite) NSString * _commentDate;
@property (retain,readwrite) NSString * _commentID;
@property (retain,readwrite) NSString * _userName;
@property (retain,readwrite) NSString * _name;

@end
