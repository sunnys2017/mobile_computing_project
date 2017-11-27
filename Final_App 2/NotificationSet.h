//
//  NotificationSet.h
//  Final_App
//
//  Created by Yeming on 4/22/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationSet : NSObject
{
    NSMutableArray * _noticeArray;
}
@property NSMutableArray * _noticeArray;

-(id)initWithNoticeArray:(NSMutableArray *) anoticeArray ;
- (void) encodeWithCoder: (NSCoder *)coder;
- (id) initWithCoder: (NSCoder *) coder;
@end
