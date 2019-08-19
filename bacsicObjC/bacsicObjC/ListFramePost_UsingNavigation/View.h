//
//  Contrainner.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

#define SPACE 20.0
#define WITDTH_IMG 100.0
#define HEIGHT_IMG 40.0
#define WITDTH_LAB 100.0
#define HEIGHT_LAB 20.0
#define HEIGHT_TIMESTAMP 20
#define WIDTH_TIMESTAMP 100
#define HEIGHT_VIEW 100.0
#define WIDTH_VIEW 400.0

#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN

@class View;
@protocol ViewDelegate <NSObject>
@required
-(void)allText:(View *)view;
@end

@interface View : UIView
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel *timeStamp;
@property (nonatomic, strong) UIImageView * thumbnail;
@property (nonatomic, weak) id<ViewDelegate> delagte;

@end


NS_ASSUME_NONNULL_END
