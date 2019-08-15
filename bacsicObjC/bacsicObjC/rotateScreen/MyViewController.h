//
//  MyViewController.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/13/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#define WIDTH 200
#define HEIGHT 100
#define WIDTH_BTN 100
#define HEIGHT_BTN 50
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_LENGTH [UIScreen mainScreen].bounds.size.height
#define SetOrigin(v, x, y)  v.frame = CGRectMake(x, y, v.frame.size.width, v.frame.size.height)
#define SetFrame(v, x, y, w, h)  v.frame = CGRectMake(x, y, w, h)


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
