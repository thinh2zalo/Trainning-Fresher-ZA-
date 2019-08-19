//
//  NavigationBar.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "../compareTimeStamp/NSString+CompareTimeStamp.h"
#import "../ParseJsonForAPost/Data.h"
#import "SecondViewController.h"
#import "ConnectData.h"
#import "../ParseJsonForAPost/Content.h"


#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NAV_HEIGHT 44

NS_ASSUME_NONNULL_BEGIN

@interface NavigationExample : UIViewController


@end

NS_ASSUME_NONNULL_END
