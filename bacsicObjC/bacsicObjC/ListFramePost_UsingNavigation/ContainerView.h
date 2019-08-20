//
//  Contrainner.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ParseJsonForAPost/Content.h"
#import "RootViewController.h"
#import "FitHight.h"

#define SPACE 20.0
#define WITDTH_IMG 120.0
#define HEIGHT_IMG 80.0
#define WITDTH_LAB 100.0
#define HEIGHT_LAB 80.0
#define HEIGHT_TIMESTAMP 20
#define WIDTH_TIMESTAMP 100
#define HEIGHT_VIEW 100.0
#define WIDTH_VIEW 400.0

#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN

@class ContainerView;
@protocol ViewDelegate <NSObject>
@required
-(void)onTouched:(ContainerView *)containerView;
@end

@interface ContainerView : UIView
@property (nonatomic) NSInteger ContentID;
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel *timeStamp;
@property (nonatomic, strong) UIImageView * thumbnail;
@property (nonatomic, weak) id<ViewDelegate> delagte;
- (void)updateContentInsideContainerView:(Content *)content;
- (CGSize)sizeThatFitsOverride:(CGSize)size;
@end


NS_ASSUME_NONNULL_END
