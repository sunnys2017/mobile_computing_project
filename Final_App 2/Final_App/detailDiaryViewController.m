//
//  detailDiaryViewController.m
//  Final_App
//
//  Created by Yeming on 4/21/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "detailDiaryViewController.h"
#import "diaryViewController.h"

@interface detailDiaryViewController ()

@end

@implementation detailDiaryViewController
Diary * dia;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setAArray{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * passString = [[NSString alloc] init];
    passString =self.title;
    diaryViewController * dvc = [[diaryViewController alloc ] init];
    dia = [[Diary alloc]init];
    dia =[dvc getMySpecificDiary:passString];
    
    self.title =dia._diaryTitle;
    _contentTextView.text = dia._diaryBody;
    _dateLable.text = dia._date;
    _diaryTitleTextField.text = dia._diaryTitle;
    _detailDiaryImage.image = dia._pic;
    [self showDiaryImage:dia._diaryID];
	// Do any additional setup after loading the view.
}

-(void)showDiaryImage:(NSString *)diaryID{
    NSString*imgpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imgpath = [imgpath stringByAppendingPathComponent:[diaryID stringByAppendingString:@".jpg"]];
    NSData * itmImage = [NSData dataWithContentsOfFile:imgpath];
    _detailDiaryImage.image = [UIImage imageWithData:itmImage];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDiaryAction:(id)sender {
}
@end
