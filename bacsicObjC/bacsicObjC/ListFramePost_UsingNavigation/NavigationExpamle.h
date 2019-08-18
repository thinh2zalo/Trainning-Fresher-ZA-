//
//  NavigationBar.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Container.h"
#import "UILabel+TopAlign.h"
#import "../ParseJsonForAPost/Data.h"
#import "SecondViewController.h"
#import "connectData.h"
#import "../ParseJsonForAPost/Content.h"


#define SAFE_TYPE(pointer, type) [pointer isKindOfClass:type.class]
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_LENGTH [UIScreen mainScreen].bounds.size.height
#define LENGTH_VIEW 100.0
#define WIDTH_VIEW 400.0
#define NAV_LENGTH self.navigationController.navigationBar.frame.size.height
NS_ASSUME_NONNULL_BEGIN

@interface NavigationExample : UIViewController


@end

NS_ASSUME_NONNULL_END
