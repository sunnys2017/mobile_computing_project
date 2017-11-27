//
//  loginSegue.m
//  Final_App
//
//  Created by Yeming on 4/23/14.
//  Copyright (c) 2014 Sunny. All rights reserved.
//

#import "loginSegue.h"
#import "mainViewController.h"

@implementation loginSegue

-(void) perform{
    UIViewController * src = (UIViewController *) self.sourceViewController;
    UIViewController * dst = (UIViewController * ) self.destinationViewController;
    mainViewController * m = [[mainViewController alloc] init];
    NSString * s = m._test;
    
    if([s isEqualToString:@"ok"]){
        [src presentViewController:dst animated:YES completion:nil ];
    }else{
        
    }
    //[src presentViewController:dst animated:YES completion:nil ];
    /*
    [UIView transitionWithView:src.view duration:3.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{[src presentViewController:dst animated:NO completion:^{[dst dismissViewControllerAnimated:YES completion:nil];}
                                  ];}
                    completion:NULL];
     */
}


@end
