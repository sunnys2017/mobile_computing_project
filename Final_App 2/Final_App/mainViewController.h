//
//  mainViewController.h
//  Final_App
//
//  Created by Yeming on 4/20/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Shake.h"

@interface mainViewController : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIButton *_loginButton;

@property (weak, nonatomic) IBOutlet UIButton *_registerButton;

@property (weak, nonatomic) IBOutlet UITextField *_userName;

@property (weak, nonatomic) IBOutlet UITextField *_password;

@property (strong, nonatomic) NSString * _test;




//@property (weak, nonatomic) IBOutlet UISegmentedControl *shakeDirection;



- (IBAction)loginAction:(id)sender;

- (IBAction)registerAction:(id)sender;

-(BOOL)textFieldShouldReturn:(UITextField *)textField;

- (IBAction)finishInput:(id)sender;

- (IBAction)textFieldEditingDidEnd:(id)sender;

- (IBAction)textFieldEditingDidBegin:(id)sender;

- (void)textFieldDidBeginEditingMethod:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;

@end
