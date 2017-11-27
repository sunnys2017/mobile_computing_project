//
//  noticeTableViewController.h
//  Final_App
//
//  Created by Yeming on 4/22/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noticeTableViewController : UITableViewController{
    NSMutableArray * _noticesArray;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNoticeButton;

@property (nonatomic,retain) NSMutableArray * _noticesArray;


@end
