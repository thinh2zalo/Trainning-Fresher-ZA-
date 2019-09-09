//
//  AlertWindow.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "AlertWindowViewController.h"

@interface AlertWindowViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *gesture;




@end

@implementation AlertWindowViewController
UIWindow * windowToAlert;
AlertView *alertView;

+ (void)showAlert:(NSString *)str {
    if (![str isKindOfClass:NSString.class]) {
        str = @"";
    }
    UIBlurEffect  *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.tag = 121212;
    
    windowToAlert = UIWindow.new;
    windowToAlert.windowLevel = UIWindowLevelStatusBar + 1;
    [windowToAlert makeKeyAndVisible];
    alertView = AlertView.new;
    
    alertView.center = windowToAlert.center;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 10;
    alertView.frame = CGRectMake(SCREEN_MAIN_WIDTH/2 - 256 / 2 ,SCREEN_MAIN_HEIGHT / 2 - 96 / 2, 256, 96);
    
    alertView.titleLab.text = str;
    NSLog(@"%@", str);
    blurEffectView.frame = windowToAlert.bounds;
    [[blurEffectView contentView] addSubview:alertView];
    [windowToAlert addSubview:blurEffectView];
    windowToAlert.backgroundColor = [UIColor clearColor];
    windowToAlert.rootViewController = AlertWindowViewController.new;
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint locationOfTouch = [touch locationInView:self.view];
    if (![ self isContaining:locationOfTouch andView:alertView]) {
        UIWindow * currentWindow = [[UIApplication sharedApplication] keyWindow];
        [currentWindow setHidden:YES];
        [alertView removeFromSuperview];
        [currentWindow removeFromSuperview];
        windowToAlert = nil;
    }
}

- (BOOL) isContaining:(CGPoint) pointOfTouch andView:(UIView *)view {
    return CGRectContainsPoint(view.frame, pointOfTouch);
}




@end
