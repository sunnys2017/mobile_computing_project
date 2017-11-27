//
//  mainViewController.m
//  Final_App
//
//  Created by Yeming on 4/20/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "mainViewController.h"
#import "tabBarMainController.h"
#import "AppDelegate.h"
#import "UserCurrent.h"

@interface mainViewController ()

@end

@implementation mainViewController
@synthesize _loginButton,_password,_registerButton,_userName,_test;

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


- (IBAction)actionShake:(id)sender
{
	[self shake];
}

- (void)shake
{
	[self.view.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
		[obj shake:10
		 withDelta:5
		  andSpeed:0.03
	shakeDirection:ShakeDirectionVertical];
	}];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
		if ([obj isKindOfClass:[UITextField class]]) {
			[obj resignFirstResponder];
		}
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    _test = @"ok";
    NSString * username =  _userName.text;
    NSString * password = _password.text;
    NSString * combine = [[username stringByAppendingString:@"$"]stringByAppendingString:password];
    NSString * url = @"authenticateWithP";
    AppDelegate * app = [[AppDelegate alloc] init];
    NSString * result = [app getGroupInfoFromWebServer:combine urlString:url method:nil];
    if([result isEqualToString:@"1"]){
        //get user info.
        NSMutableArray * array = [app getInfoFromWebServer:username urlString:@"authenticate" method:nil];

        //Restore current user
        User * user  = [array  objectAtIndex:0];
        
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
        NSArray *myuserList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(myuserList==nil){
            UserCurrent * userCurrent = [[UserCurrent alloc] init];
            userCurrent._role = user._role;
            userCurrent._groupNumber=user._groupNumber;
            userCurrent._name=user._name;
            userCurrent._password=user._password;
            userCurrent._profile=user._profile;
            userCurrent._userName=user._userName;
            BOOL b =[NSKeyedArchiver archiveRootObject: userCurrent toFile:(NSString *)path];
            NSLog(@"Test CURRENTUSER STORE S=1 %hhd.\n", b);
        }else{
            UserCurrent * userCurrent = [[UserCurrent alloc] init];
            userCurrent._role = user._role;
            userCurrent._groupNumber=user._groupNumber;
            userCurrent._name=user._name;
            userCurrent._password=user._password;
            userCurrent._profile=user._profile;
            userCurrent._userName=user._userName;
            BOOL b =[NSKeyedArchiver archiveRootObject: userCurrent toFile:(NSString *)path];
            NSLog(@"Test CURRENTUSER STORE S=1 %hhd.\n", b);
        }
        

        //present next tabbarcontroller.
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        tabBarMainController * tab = [storyboard instantiateViewControllerWithIdentifier:@"tabbarmain"];
        [self presentViewController:tab animated:true completion:nil];
    }
    else {
        [self.view shake:10   // 10 times
               withDelta:5    // 5 points wide
                andSpeed:0.03 // 30ms per shake
          shakeDirection:ShakeDirectionVertical
         ];
    }
    
    
}

/*
-(void) performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}
 */


- (IBAction)registerAction:(id)sender {
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //print text
    NSLog(@"You typed :%@", [textField text]);
    
    //or use an alert screen to display it
    NSString * msg = [NSString stringWithFormat:@"You typed : %@", [textField text]];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
    //the user pressed the "done" button, so dismiss the keyboard.
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)finishInput:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)textFieldEditingDidEnd:(id)sender {
    [self textFieldDidEndEditing:sender];
}

- (IBAction)textFieldEditingDidBegin:(id)sender {
    [self textFieldDidBeginEditingMethod:sender];
}

- (void)textFieldDidBeginEditingMethod:(UITextField *)textField{
    
    CGFloat keyboardHeight = 216.0f;
    if (self.view.frame.size.height - keyboardHeight <= textField.frame.origin.y + textField.frame.size.height) {
        CGFloat y = textField.frame.origin.y - (self.view.frame.size.height - keyboardHeight - textField.frame.size.height -5);
        [UIView beginAnimations:@"srcollView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        self.view.frame = CGRectMake(self.view.frame.origin.x, -y, self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView beginAnimations:@"srcollView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
    
}

@end
