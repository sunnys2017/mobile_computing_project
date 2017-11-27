//
//  addDiaryViewController.m
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "addDiaryViewController.h"
#import "UserCurrent.h"
#import "User.h"

@interface addDiaryViewController ()

@end

@implementation addDiaryViewController
UIImage * image;
@synthesize _diaryImage,_body,_addpicButton,_saveButton,diaryTitle;

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

- (IBAction)addpicAction:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init ];
    picker.delegate =self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // or UIImagePickerControllerSourceTypePhotoLibrary
    [self  presentViewController:picker animated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    
    NSString * _diaryTitle =  [diaryTitle.text stringByAppendingString:@"             "];
    NSString * _diaryBody = _body.text;
    
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    NSString * curDate = [dateFormatter stringFromDate:[NSDate date]];

    NSString * _date = curDate;
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSString * _userName = userCur._userName;
    
    NSString * _diaryID = [_diaryTitle stringByAppendingString:curDate];
    
    
    User * user = [[User alloc]init];
    //stor image
    NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imgpath = [imgpath stringByAppendingPathComponent:[_diaryID stringByAppendingString:@".jpg"]];
    NSData* bimage = UIImagePNGRepresentation(image);
    [bimage writeToFile:imgpath atomically:YES];
    
    //ADD DIARY IN SQLITE.
    [user InsertRecords:_diaryTitle :_diaryBody :_date :_userName :nil :_diaryID];
    
    
    
}

- (IBAction)finishInputForTextView:(id)sender {
    [_body resignFirstResponder];
}




//added for UIImageDelegate protocol
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _diaryImage.image=image;
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
