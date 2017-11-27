//
//  registerViewController.m
//  Final_App
//
//  Created by Yeming on 4/23/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "registerViewController.h"
#import "AppDelegate.h"
#import "UserCurrent.h"
#import "tabBarMainController.h"
@interface registerViewController ()

@end

@implementation registerViewController
UIImage* image;

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

- (IBAction)submitAction:(id)sender {

    if(_userNameTextField.text==nil ||_passwordTextField.text==nil){
        NSString * msg = @"UserName & password can't be null.";
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    AppDelegate * app = [[AppDelegate alloc]init];
    
    if(_userNameTextField.text!=nil){
        NSString * s =_userNameTextField.text;
        //connect database if the user has been used.
        NSMutableArray * array =[app getInfoFromWebServer:s urlString:@"authenticate" method:nil];
        if(array.count !=0){
            NSString * msg = @"UserName has been taken, please change.";
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    if(_groupNumberTextField!=nil){
        NSString * g= _groupNumberTextField.text;
        NSString * result = [app getGroupInfoFromWebServer:g urlString:@"group" method:nil];
        if([result isEqualToString:@"0"]){
            NSString * msg = @"No such group, please double check group number.";
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imgpath = [imgpath stringByAppendingPathComponent:[_userNameTextField.text stringByAppendingString:@".jpg"]];
    NSData* bimage = UIImagePNGRepresentation(image);
    [bimage writeToFile:imgpath atomically:YES];
    
    //const char * pic=[[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[_userNameTextField.text  stringByAppendingString:@".jpg"]]UTF8String];
    NSString * regString = @"";
    User * user = [[User alloc]init];
    user._groupNumber = _groupNumberTextField.text;
    user._name = _nickNameTextField.text;
    user._userName = _userNameTextField.text;
    user._password = _passwordTextField.text;
    user._role = @"member";
    
    NSString * combineString = [[[[[[[[[regString  stringByAppendingString:_userNameTextField.text]stringByAppendingString:@"$"]stringByAppendingString:_passwordTextField.text]stringByAppendingString:@"$"]stringByAppendingString:_groupNumberTextField.text]stringByAppendingString:@"$"]stringByAppendingString:_nickNameTextField.text]stringByAppendingString:@"$"]stringByAppendingString:@"member"];
    
    NSString * result = [app getGroupInfoFromWebServer:combineString urlString:@"register" method:nil];
    if([result isEqualToString:@"ok"]){
        
        //restore current user.
        
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
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        tabBarMainController * tab = [storyboard instantiateViewControllerWithIdentifier:@"tabbarmain"];
        [self presentViewController:tab animated:true completion:nil];
        
    }else{
        NSString * msg = @"Sorry something is wrong.";
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }

}





//added for UIImageDelegate protocol
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _profileImageView.image=image;
}

- (IBAction)addImageAction:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init ];
    picker.delegate =self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // or UIImagePickerControllerSourceTypePhotoLibrary
    [self  presentViewController:picker animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //print text
    NSLog(@"You typed :%@", [textField text]);
    
    //or use an alert screen to display it
    NSString * msg = [NSString stringWithFormat:@"You typed : %@", [textField text]];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
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
