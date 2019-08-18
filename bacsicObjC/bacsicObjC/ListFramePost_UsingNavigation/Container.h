//
//  Contrainner.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NavigationExpamle.h"
#import "UILabel+TopAlign.h"
#define SPACE 20.0
#define WITDTH_BTN 100.0
#define LENGTH_BTN 80.0

#define WITDTH_LAB 100.0
#define LENGTH_LAB 20.0

#define LENGTH_OF_LABEL  WIDTH_VIEW - self.label.frame.size.width

#define fontSize self.label.font.pointSize
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_LENGTH [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN
@class Container;
@protocol callSecondViewController <NSObject>
@required

-(void)callSencondVC:(Container *)container;
@end
@interface Container : UIView
@property (nonatomic, strong) UILabel * label; 
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, weak) id<callSecondViewController> delagte;

@end


NS_ASSUME_NONNULL_END
