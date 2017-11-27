//
//  datePickerViewController.h
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface datePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *addNotificationButton;

- (IBAction)addNotificationAction:(id)sender;

@end
