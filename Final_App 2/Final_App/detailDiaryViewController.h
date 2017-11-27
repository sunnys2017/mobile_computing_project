//
//  detailDiaryViewController.h
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Diary.h"
@interface detailDiaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *diaryTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *detailDiaryImage;

- (IBAction)updateDiaryAction:(id)sender;

-(void) setAArray;

@end
