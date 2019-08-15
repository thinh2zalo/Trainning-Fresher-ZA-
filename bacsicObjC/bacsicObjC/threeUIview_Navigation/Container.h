//
//  Contrainner.h
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"
#define LENGTH_VIEW 100.0
#define WIDTH_VIEW 200.0
#define SPACE 20.0
#define WITDTH_BTN 50.0
#define LENGTH_BTN 50.0

#define WITDTH_LAB 100.0
#define LENGTH_LAB 20.0

#define fontSize self.label.font.pointSize
#define SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAIN_LENGTH [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN

@interface Container : UIView
@property (nonatomic, strong) UILabel * label; 
@property (nonatomic, strong) UIButton * button;

@end

NS_ASSUME_NONNULL_END
