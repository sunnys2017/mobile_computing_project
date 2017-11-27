//
//  detailPostNewsViewController.h
//  Final_App
//
//  Created by Yeming on 4/25/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsViewController.h"
#import "AppDelegate.h"
@interface detailPostNewsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *postTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;

@property (weak, nonatomic) IBOutlet UITextView *postBodyTextView;


@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *commentALable;
@property (weak, nonatomic) IBOutlet UILabel *commentBLable;
@property (weak, nonatomic) IBOutlet UILabel *commentCLable;

@property (weak, nonatomic) IBOutlet UIButton *moreCommentsButton;
@property (weak, nonatomic) IBOutlet UITextField *myCommentTextField;


- (IBAction)commentAction:(id)sender;



- (IBAction)finishInput:(id)sender;

- (IBAction)textFieldEditingDidEnd:(id)sender;

- (IBAction)textFieldEditingDidBegin:(id)sender;

- (void)textFieldDidBeginEditingMethod:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;



@end
