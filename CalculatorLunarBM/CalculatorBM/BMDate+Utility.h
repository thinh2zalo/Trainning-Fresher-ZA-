//
//  BMDate+Utility.h
//  CalculatorBM
//
//  Created by vincent on 2/21/20.
//  Copyright © 2020 vincent. All rights reserved.
//



#import "BMDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMDate (Utility)

+ (NSArray *)getYearArrWithStartYear:(BMDate *)startDate andEndYear:(BMDate *)endDate andTypeOfCalendar:(TypeOfCalendar) typeOfCalendar;
+ (NSArray *)getTypeCalendarArr;

+ (NSArray *)getMonthArr:(NSInteger)year minDate:(BMDate *)minDate maxDate:(BMDate *)maxDate  andTypeCalendar:(TypeOfCalendar)typeOfCalendar;

+ (NSArray *)getLunarDayArr:(NSInteger)year month:(NSInteger)month minDate:(BMDate *)minDate maxDate:(BMDate *)maxDate isLeapMonth:(BOOL)isLeapMonth;

+ (NSArray *)getSolarDayArr:(NSInteger)year month:(NSInteger)month minDate:(BMDate *)minDate maxDate:(BMDate *)maxDate;

+ (BMDate *)getCurrentDate ;
+ (NSDateComponents *)getCurrentDateComponents ;

+ (NSInteger)getDaysInLunarYear:(NSInteger)year month:(NSInteger)month isLeapMonth:(BOOL)isLeapMonth;

+ (NSInteger)getDaysInSolarYear:(NSInteger)year month:(NSInteger)month;

+(BOOL)indexOfLeapLunarMonthInArr:(NSArray *)monthArr;

- (NSString *)getStringMonth:(TypeOfCalendar)typeOfCalendar;

@end

NS_ASSUME_NONNULL_END
