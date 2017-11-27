//
//  addNewPostViewController.m
//  Final_App
//
//  Created by Yeming on 4/23/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "addNewPostViewController.h"



@interface addNewPostViewController ()

@end

@implementation addNewPostViewController
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

- (IBAction)addPicAction:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init ];
    picker.delegate =self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // or UIImagePickerControllerSourceTypePhotoLibrary
    [self  presentViewController:picker animated:YES completion:nil];
}

- (IBAction)publishAction:(id)sender {
    NSString * title = _postTitleTextField.text;
    NSString * postBody = _postBodyTextView.text;
    if([_postTitleTextField.text isEqualToString:@"" ]|| _postTitleTextField.text ==nil){
        NSString * msg = [NSString stringWithFormat:@"Please input title"];
        [self showMessage:msg];
        return;
    }
    
    if([postBody isEqualToString:@""] || postBody ==nil){
        postBody = @"RT default";
    }
    //NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    //[dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];

    //NSString * dateCurrent = [dateFormatter stringFromDate:[NSDate date]];
    
    AppDelegate * app = [[AppDelegate alloc]init];
    UserCurrent * userC = [[UserCurrent alloc]init];
    userC = [app getCurrentUser];
    NSString * userName =  userC._userName;
    Post * post = [[Post alloc]init];
    
    post._groupNumber = userC._groupNumber; //app.groupid;
    post._userName = userName;
    post._postTitle = title;
    //post._postID = [[title stringByAppendingString:@" "]stringByAppendingString:dateCurrent];
    //post._postImage = [userName stringByAppendingString:dateCurrent];
    //post._postDate = dateCurrent;
    post._postBody = postBody;
    post._name = userC._name;//app.user._name;
    
    NSString * regString = @"";
    NSMutableArray *a = [NSMutableArray array];
    for (int i = 0; i < 8; i++){
        [a addObject: [NSNumber numberWithInt: arc4random()%10]];
    }
    //[postBody stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString *s = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",userName, [a objectAtIndex:0],[a objectAtIndex:1],[a objectAtIndex:2],[a objectAtIndex:3],[a objectAtIndex:4],[a objectAtIndex:5],[a objectAtIndex:6],[a objectAtIndex:7]];
    
    NSString * finalPost = [[[[[[[[[[[regString stringByAppendingString:userName]
                                     stringByAppendingString:@"#$"]
                                    stringByAppendingString:title]
                               stringByAppendingString:@"#$"]
                              stringByAppendingString:postBody]
                             stringByAppendingString:@"#$"]
                            stringByAppendingString:post._name ]
                            stringByAppendingString:@"#$"]
                            stringByAppendingString:post._groupNumber]
    stringByAppendingString:@"#$"]
    stringByAppendingString:s];

    NSString * result = [app getGroupInfoFromWebServer:finalPost urlString:@"postNews" method:nil];
    //NSLog(@"------my post id is ------%@",result);
    

    
    NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imgpath = [imgpath stringByAppendingPathComponent:[result stringByAppendingString:@".jpg"]];
    NSData* bimage = UIImagePNGRepresentation(image);
    [bimage writeToFile:imgpath atomically:YES];
    
    if(result!=nil || [result isEqualToString:@""]){
        NSString * msg = @"Success.";
        [self showMessage:msg];
    }
    
}

-(void)showMessage:(NSString *)msg{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}


//added for UIImageDelegate protocol
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _postImageView.image=image;
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

//button action and textfield

- (IBAction)finishInput:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)finishInputForTextView:(id)sender {
    [_postBodyTextView resignFirstResponder];
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
