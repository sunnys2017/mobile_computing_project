//
//  Diary.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diary : NSObject{
    NSString * _diaryTitle;
    NSString * _diaryBody;
    NSString * _date;
    UIImage * _pic;
    NSString * _userName;
    NSString * _diaryID;
}

@property (readwrite,retain) NSString * _diaryTitle;
@property (readwrite,retain) NSString * _diaryBody;
@property (readwrite,retain) NSString * _date;
@property (readwrite,retain) UIImage * _pic;
@property (readwrite,retain) NSString * _userName;
@property (readwrite,retain) NSString * _diaryID;

-(id)initWithDiaryTitle:(NSString *) adiaryTitle
           andDiaryBody:(NSString *) adiaryBody
                andDate:(NSString *) aDate
                 andPic:(UIImage *) apic
            andUserName:(NSString *) auserName
             andDiaryID:(NSString *) adiaryID;

@end
