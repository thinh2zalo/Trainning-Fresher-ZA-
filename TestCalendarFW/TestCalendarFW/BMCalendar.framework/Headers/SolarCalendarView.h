//
//  SolarCalenDarView.h
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
#import "DateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SolarCalendarView : UIView
@property (nonatomic, strong) UILabel * solarDayLabel;
@property (nonatomic, strong) UILabel * solarMonthLabel;
@property (nonatomic, strong) UILabel * solarMonthAndYearLabel;

@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) UILabel * quoteLabel;

@property (nonatomic, strong) UILabel * solarYearLabel;
@property (nonatomic, strong) UILabel * dayOfWeekLabel;
- (void)loadDateWithInput:(DateModel *)dataModel;
 
@end

NS_ASSUME_NONNULL_END
