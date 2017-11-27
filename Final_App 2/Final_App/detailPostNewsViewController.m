//
//  detailPostNewsViewController.m
//  Final_App
//
//  Created by Yeming on 4/25/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "detailPostNewsViewController.h"

@interface detailPostNewsViewController ()

@end

@implementation detailPostNewsViewController

Post * postt;

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
    
    NSString * passString = [[NSString alloc] init];
    passString =self.title;
    
    postt = [[Post alloc]init];
    postt =[self getSpecificPost:passString];
    
    _postTitleLable.text = postt._postTitle;
    _dateLable.text = postt._postDate;
    _postBodyTextView.text = postt._postBody;
    
    self.title =[postt._name stringByAppendingString:@"'s post"];
    
     [self showDiaryImage:postt._userName imageView:_authorImageView];
    [self showDiaryImage:postt._postImage imageView:_postImageView];
    _commentALable.text =@"";
    _commentBLable.text =@"";
    _commentCLable.text =@"";
    
    [self setCommentLables];
	// Do any additional setup after loading the view.
}

-(void)setCommentLables{
    AppDelegate * app = [[AppDelegate alloc]init];
    NSMutableArray * array =[app getInfoFromWebServer:postt._postID urlString:@"comment" method:nil];
    if(array.count ==1){
        Comment * c = [[Comment alloc]init];
        c = [array objectAtIndex:0];
        _commentALable.text =[[c._name stringByAppendingString:@":"]stringByAppendingString:c._commentBody];
    }else if(array.count ==2){
        Comment * c = [[Comment alloc]init];
        c = [array objectAtIndex:0];
        _commentALable.text =[[c._name stringByAppendingString:@":"]stringByAppendingString:c._commentBody];
        c = [array objectAtIndex:1];
        _commentBLable.text =[[c._name stringByAppendingString:@":"]stringByAppendingString:c._commentBody];
    }else if(array.count >=3){
        Comment * c = [[Comment alloc]init];
        c = [array objectAtIndex:0];
        _commentALable.text =[[c._name stringByAppendingString:@":"]stringByAppendingString:c._commentBody];
        c = [array objectAtIndex:1];
        _commentBLable.text =[[c._name stringByAppendingString:@":"]stringByAppendingString:c._commentBody];
        c = [array objectAtIndex:2];
        _commentCLable.text =[[c._name stringByAppendingString:@":"]stringByAppendingString:c._commentBody];
    }
}

-(NSMutableArray *)getPostsArray{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSString * groupnumber = userCur._groupNumber;
    NSString * urlt = @"post";
    AppDelegate * app = [[AppDelegate alloc]init];
    NSMutableArray * tempArray =[app getInfoFromWebServer:(NSString *) groupnumber urlString:(NSString *)urlt method:(NSString *)nil];
    return tempArray;
}

-(Post *) getSpecificPost:(NSString *)postID{
    for(Post* obj in [self getPostsArray]){
        if([[obj _postID] isEqualToString:postID]){
            return obj;
        }
    }
    return nil;
}


-(void)showDiaryImage:(NSString *)diaryID imageView:(UIImageView *)imageView{
    NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imgpath = [imgpath stringByAppendingPathComponent:[diaryID stringByAppendingString:@".jpg"]];
    NSData * itmImage = [NSData dataWithContentsOfFile:imgpath];
    if (itmImage==nil) {
        imageView.image = [UIImage imageNamed:@"button-02.png"];
    }else{
    imageView.image = [UIImage imageWithData:itmImage];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commentAction:(id)sender {
    NSString * postID = postt._postID;
    NSString * commentBody =_myCommentTextField.text;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myCurrentUser.txt"];
    UserCurrent * userCur  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSString * name = userCur._name;
    Comment * myComment = [[Comment alloc]init];
    myComment._name =name;
    myComment._commentBody =commentBody;
    myComment._postID = postID;
    AppDelegate * app = [[AppDelegate alloc ] init];
    
    NSString * commentString = [[[[postID stringByAppendingString:@"#$"]stringByAppendingString:commentBody]stringByAppendingString:@"#$"]stringByAppendingString:name];
    [app getGroupInfoFromWebServer:commentString urlString:@"postComments"  method:nil];
    [self setCommentLables];
    [self showMessage:@"Comment Success."];
    _myCommentTextField.text = @"";
    [_myCommentTextField resignFirstResponder];
    
}

-(void)showMessage:(NSString *)msg{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
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
