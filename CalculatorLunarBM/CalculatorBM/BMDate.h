//
//  BMDate.h
//  CalculatorBM
//
//  Created by vincent on 2/11/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "BMYear.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMDate : NSObject
// creational function for init class BMDate with some diffrence options
- (instancetype)initDate:(NSString *)stringDate andTimeZone:(NSInteger)timeZone;
- (instancetype)initDateWithSolarDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy andTimeZone:(NSInteger)timeZone;
-  (instancetype)initLocalDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy;
- (instancetype)initDateWithLunarDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy isLeapMonth:(BOOL)isLeapMonth andTimeZone:(NSInteger)timeZone;
// kiểm tra tháng hiện tại có phải tháng nhuận hay không ?
- (BOOL)isLeapLunarMonth;
// kiểm tra có phải năm nhuận trong dương lịch hay không
- (BOOL)isLeapLunarYear;
// kiểm tra có phải năm nhuận trong âm lịch hay không
- (BOOL)isLeapSolarYear;
// valiedate một ngày dương lịch
+ (BOOL)validDate:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;
// so sánh 2 ngày. true ngày so sánh lớn hơn ngày nhập
-(BOOL)bmDate_compare:(BMDate *)date;


// function Public API
// get ngày tháng năm trong hệ can chi
- (NSString*)getNgayCanChi;
- (NSString *)getThangCanChi;
- (NSString *)getNamCanChi;

// get ngày tháng năm âm lịch
- (NSInteger)getLunarDay;
- (NSInteger)getLunarMonth;
- (NSInteger)getlunarYear;
// get ngày tháng năm dương lịch
- (NSInteger)getSolarDay;
- (NSInteger)getSolarMonth;
- (NSInteger)getSolarYear;
- (NSString*)dayOfWeek;
// get tháng nhuận trong năm
-(NSInteger)getLeapLunarMonth;

// gét ngày tháng năm với một kiểu lịch nào đo
- (NSInteger)getDayWithTypeCalendar:(TypeOfCalendar)typeOfCalendar;
- (NSInteger)getMonthWithTypeCalendar:(TypeOfCalendar)typeOfCalendar;
- (NSInteger)getYearWithTypeCalendar:(TypeOfCalendar)typeOfCalendar;
- (NSInteger)getIndexOfMonthInYear:(TypeOfCalendar)typeOfCalendar;


@end

NS_ASSUME_NONNULL_END
