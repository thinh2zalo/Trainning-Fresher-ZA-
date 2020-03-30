//
//  LunarView.h
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
NS_ASSUME_NONNULL_BEGIN

@interface LunarCalendarView : UIView
- (void)loadDateWithInput:(BMDate *)date;
@property (nonatomic, strong) UILabel * lunarHourTitleLabel;
@property (nonatomic, strong) UILabel * hourLabel;
@property (nonatomic, strong) UILabel * hourCanChiLabel;
@property (nonatomic, strong) UIView * hourView;

@property (nonatomic, strong) UILabel * lunarDayTitleLabel;
@property (nonatomic, strong) UILabel * lunarDayLabel;
@property (nonatomic, strong) UILabel * canChiDayLabel;
@property (nonatomic, strong) UIView * lunarDayView;

@property (nonatomic, strong) UILabel * lunarMonthTitleLabel;
@property (nonatomic, strong) UILabel * lunarMonthLabel;
@property (nonatomic, strong) UILabel * canChiMonthLabel;
@property (nonatomic, strong) UILabel * canChiYearLabel;
@end

NS_ASSUME_NONNULL_END
