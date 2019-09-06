//
//  AlertWindow.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "AlertWindowViewController.h"

@interface AlertWindowViewController () {
    
}


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
    windowToAlert.windowLevel = UIWindowLevelStatusBar;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint locationOfTouch = [touch locationInView:self.view];
    if (![ self isContaining:locationOfTouch andView:alertView]) {
        UIWindow * currentWindow = [[UIApplication sharedApplication] keyWindow];
        [currentWindow setHidden:YES];
    }
    
}

- (BOOL) isContaining:(CGPoint) pointOfTouch andView:(UIView *)view {
    float originX = view.frame.origin.x;
    float originY = view.frame.origin.y;
    float widthView = view.frame.size.width;
    float heightView = view.frame.size.height;
    if ( pointOfTouch.x >= originX && pointOfTouch.x <= (originX + widthView) &&
        pointOfTouch.y >= originY && pointOfTouch.y <= (originY + heightView )) {
        return true;
    }
    return false;
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
