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
/** @property selectDate
*   @brief   Set the selected time */
@property (nonatomic, strong) BMDate * selectDate;
/** @property minDate
*   @brief   set min Date in datePicker*/
@property (nonatomic, strong) BMDate * minDate;
/** @property maxDate
*   @brief   set max Date in datePicker*/
@property (nonatomic, strong) BMDate * maxDate;
/** @property typeOfCalendar
*   @brief   set type of calendar  lunar calendar || solar calendar */
@property (nonatomic) TypeOfCalendar typeOfCalendar;


- (void)show;
@end

NS_ASSUME_NONNULL_END
