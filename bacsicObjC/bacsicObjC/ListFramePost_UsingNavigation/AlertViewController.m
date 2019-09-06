//
//  AlertViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if (touch.view != self.view) {
    UIWindow * currentWindow = [[UIApplication sharedApplication] keyWindow];
    [currentWindow setHidden:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
