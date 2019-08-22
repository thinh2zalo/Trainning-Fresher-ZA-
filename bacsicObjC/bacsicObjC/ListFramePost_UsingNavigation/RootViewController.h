//
//  NavigationBar.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerCell.h"
#import "../compareTimeStamp/NSString+CompareTimeStamp.h"
#import "../ParseJsonForAPost/DataModel.h"
#import "SecondViewController.h"
#import "ConnectData.h"
#import "../ParseJsonForAPost/ContentModel.h"

#define HEIGHT_BTN 30
#define WIDTH_BTN 90
#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NAV_HEIGHT 44

NS_ASSUME_NONNULL_BEGIN

@interface NavigationExample : UIViewController 
extern int globalX;

@end

NS_ASSUME_NONNULL_END
