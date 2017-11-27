//
//  diaryViewController.h
//  Final_App
//
//  Created by Yeming on 4/17/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Diary.h"
#import "UserCurrent.h"

@interface diaryViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate,UIApplicationDelegate,UITextFieldDelegate,UISearchBarDelegate>{
    NSMutableArray * _contents;
    NSMutableArray * _filteredContents;
}



@property (nonatomic, strong)NSMutableArray * _contents;
@property (nonatomic, strong)NSMutableArray * _filteredContents;



- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar ;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
- (NSMutableArray *)getMyDiaryArray;
-(Diary *)getMySpecificDiary:(NSString *)diaryID;
@end
