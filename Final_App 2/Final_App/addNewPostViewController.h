//
//  addNewPostViewController.h
//  Final_App
//
//  Created by Yeming on 4/23/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "AppDelegate.h"
#import "newsViewController.h"
#import "UserCurrent.h"
@interface addNewPostViewController : UIViewController<UINavigationControllerDelegate,UIApplicationDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *postTitleTextField;

@property (weak, nonatomic) IBOutlet UITextView *postBodyTextView;

@property (weak, nonatomic) IBOutlet UIButton *addPicButton;

@property (weak, nonatomic) IBOutlet UIButton *publishButton;

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;


- (IBAction)addPicAction:(id)sender;

- (IBAction)publishAction:(id)sender;

- (IBAction)finishInputForTextView:(id)sender ;
    
-(BOOL)textFieldShouldReturn:(UITextField *)textField;

- (IBAction)finishInput:(id)sender;

- (IBAction)textFieldEditingDidEnd:(id)sender;

- (IBAction)textFieldEditingDidBegin:(id)sender;

- (void)textFieldDidBeginEditingMethod:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;

@end
