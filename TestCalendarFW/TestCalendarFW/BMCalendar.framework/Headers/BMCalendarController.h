//
//  BMCalendarController.h
//  CalculatorBM
//
//  Created by vincent on 3/10/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMButtonLabel.h"
#import "LunarCalendarView.h"
#import "SolarCalendarView.h"
#import "BMPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMCalendarController : UIViewController
@property (nonatomic, strong) BMButtonLabel * solarMonthYearView;
@property (nonatomic, strong) BMButtonLabel * toDayLabel;

@property (nonatomic, strong) LunarCalendarView * lunarCalendarView;
@property (nonatomic, strong) SolarCalendarView * solarCalenDarView;

@property (nonatomic, strong) BMPageViewController * pageViewController;

@property (nonatomic, strong) UIImageView * backgroundImgView;
@property (nonatomic, strong) BMDate * date;

- (void)importImages:(NSArray *)imgs;
- (void)importQuotations:(NSArray *)quotations;
@end

NS_ASSUME_NONNULL_END
