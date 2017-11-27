//
//  registerViewController.h
//  Final_App
//
//  Created by Yeming on 4/23/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController<UINavigationControllerDelegate,UIApplicationDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *groupNumberTextField;

@property (weak, nonatomic) IBOutlet UIButton *addPageButton;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)submitAction:(id)sender;

- (IBAction)addImageAction:(id)sender;


- (IBAction)finishInput:(id)sender;

- (IBAction)textFieldEditingDidEnd:(id)sender;

- (IBAction)textFieldEditingDidBegin:(id)sender;

- (void)textFieldDidBeginEditingMethod:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;

@end
