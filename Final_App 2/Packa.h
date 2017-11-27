//
//  Package.h
//  Final_App
//
//  Created by Yeming on 4/23/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Packa : NSObject{
    NSMutableArray * _userArrayP;
    NSMutableArray * _postArrayP;
    NSMutableArray * _commentArrayP;

}


@property (nonatomic, retain) NSMutableArray * _userArrayP;
@property (nonatomic, retain) NSMutableArray * _postArrayP;
@property (nonatomic, retain) NSMutableArray * _commentArrayP;

@end
