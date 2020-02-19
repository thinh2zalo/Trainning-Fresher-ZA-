//
//  BMDate.h
//  CalculatorBM
//
//  Created by vincent on 2/11/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMDate : NSObject
- (instancetype)initDate:(NSString *)stringDate andTimeZone:(NSInteger)timeZone;
- (instancetype)initDateWithSolarDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy andTimeZone:(NSInteger)timeZone;
-  (instancetype)initLocalDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy;
- (instancetype)initDateWithLunarDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy isLeapMonth:(BOOL)isLeapMonth andTimeZone:(NSInteger)timeZone;

- (BOOL)isLeapLunarMonth;
- (BOOL)isLeapLunarYear;
- (BOOL)isLeapSolarYear;

+ (BOOL)validDate:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;


- (NSString*)getNgayCanChi;
- (NSString *)getThangCanChi;
- (NSString *)getNamCanChi;
- (NSInteger)getLunarDay;
- (NSInteger)getLunarMonth;
- (NSInteger)getlunarYear;
- (NSInteger)getSolarDay;
- (NSInteger)getSolarMonth;
- (NSInteger)getSolarYear;
- (NSString*)dayOfWeek;
-(NSInteger)getLeapLunarMonth;


+ (NSInteger)getDaysInLunarYear:(NSInteger)year month:(NSInteger)month leapMonth:(NSInteger)leapMonth;

+ (NSArray *) getSolarDayArr:(NSInteger)year month:(NSInteger)month;
+ (NSArray *) getLunarDayArr:(NSInteger)year month:(NSInteger)month isLeapMonth:(BOOL)isLeapMonth;

+ (NSArray *)getYearArrWithStartYear:(NSInteger)startYear andEndYear:(NSInteger)endYear;
+ (NSArray *)getMonthArr:(NSInteger)year andTypeCalendar:(TypeOfCalendar)typeOfCalendar;
+ (NSArray *)getTypeCalendars;
+ (NSArray *)getDayArr:(NSInteger)year month:(NSInteger)month andTypeOfCalendar:(TypeOfCalendar) typeOfCalendar;
+ (NSDateComponents *)getCurrentDateComponents;
+ (BMDate *)getCurrentDate;

@end

NS_ASSUME_NONNULL_END
