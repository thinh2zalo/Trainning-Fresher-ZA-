//
//  LunarDatePickerView.h
//  CalculatorBM
//
//  Created by vincent on 2/13/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
#import "define.h"
NS_ASSUME_NONNULL_BEGIN

@interface LunarDatePickerView : UIView
@property (nonatomic, strong) BMDate * selectDate;
@property (nonatomic, strong) BMDate * minDate;
@property (nonatomic, strong) BMDate * maxDate;

@property (nonatomic) TypeOfCalendar typeOfCalendar;


- (void)show;
@end

NS_ASSUME_NONNULL_END
