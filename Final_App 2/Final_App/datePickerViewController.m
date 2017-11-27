//
//  datePickerViewController.m
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "datePickerViewController.h"
#import "AppDelegate.h"


@interface datePickerViewController ()

@end

@implementation datePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNotificationAction:(id)sender {
    NSDate * date = _datePicker.date;
    NSDate * currentDate = [NSDate date];
    if ([date compare:currentDate]==NSOrderedSame || [date compare:currentDate]==NSOrderedAscending) {
        NSLog(@"big ascending or same");
        
    }else{
        NSString * title =@"";
        if (_titleTextField.text==nil) {
            title=@"Notice";
        }else{
            title = _titleTextField.text;
        }
        AppDelegate * app = [[AppDelegate alloc]init];
        [app setNotification:(NSDate *) date title:(NSString *) title];

    }

}
@end
