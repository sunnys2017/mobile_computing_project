//
//  profileViewController.h
//  Final_App
//
//  Created by Yeming on 4/22/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *nicknameLable;

@property (weak, nonatomic) IBOutlet UILabel *userNameLable;

@property (weak, nonatomic) IBOutlet UILabel *groupNumberLable;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)logoutAction:(id)sender;

@end
