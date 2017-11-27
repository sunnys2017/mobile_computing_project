//
//  Diary.m
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "Diary.h"

@implementation Diary
@synthesize _diaryTitle,_diaryBody,_date,_pic,_userName,_diaryID;

-(id)initWithDiaryTitle:(NSString *) adiaryTitle
           andDiaryBody:(NSString *) adiaryBody
                andDate:(NSString *) aDate
                 andPic:(UIImage *) apic
            andUserName:(NSString *)auserName
             andDiaryID:(NSString *) adiaryID
{
    if(self==[super init]){
        _diaryTitle = adiaryTitle;
        _diaryBody = adiaryBody;
        _date = aDate;
        _pic = apic;
        _userName = auserName;
        _diaryID = adiaryID;
    }
    return self;
}

@end
