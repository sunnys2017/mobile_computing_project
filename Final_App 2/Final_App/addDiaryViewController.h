//
//  addDiaryViewController.h
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addDiaryViewController : UIViewController
<UINavigationControllerDelegate,UIApplicationDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *diaryTitle;

@property (weak, nonatomic) IBOutlet UITextView *_body;

@property (weak, nonatomic) IBOutlet UIButton *_addpicButton;

@property (weak, nonatomic) IBOutlet UIButton *_saveButton;

@property (weak, nonatomic) IBOutlet UIImageView *_diaryImage;


- (IBAction)addpicAction:(id)sender;

- (IBAction)saveAction:(id)sender;

- (IBAction)finishInput:(id)sender;

- (IBAction)finishInputForTextView:(id)sender;


- (IBAction)textFieldEditingDidEnd:(id)sender;

- (IBAction)textFieldEditingDidBegin:(id)sender;

- (void)textFieldDidBeginEditingMethod:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;


@end
