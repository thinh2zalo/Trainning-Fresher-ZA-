//
//  BMDate+Utility.m
//  CalculatorBM
//
//  Created by vincent on 2/21/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMDate+Utility.h"
#import "BMDate.h"
#import "LunarUtils.h"
//#import <AppKit/AppKit.h>


@implementation BMDate (Utility)



+ (NSArray *)getLunarDayArr:(NSInteger)year month:(NSInteger)month minDate:(BMDate *)minDate maxDate:(BMDate *)maxDate isLeapMonth:(BOOL)isLeapMonth {
    NSInteger startDay = 1;
    NSInteger endDay;
    endDay = [BMDate getDaysInLunarYear:year month:month isLeapMonth:isLeapMonth];
    if ((year == minDate.getlunarYear) && (month == minDate.getLunarMonth)) {
        startDay = minDate.getLunarDay;
    }
    if ((year == maxDate.getlunarYear) && (month == maxDate.getLunarMonth)) {
        endDay = maxDate.getLunarDay;
    }
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    return tempArr;
}

+ (NSArray *)getSolarDayArr:(NSInteger)year month:(NSInteger)month minDate:(BMDate *)minDate maxDate:(BMDate *)maxDate {
    NSInteger startDay = 1;
    NSInteger endDay = [BMDate getDaysInSolarYear:year month:month];
    if ((year == minDate.getSolarYear) && (month == minDate.getSolarMonth)) {
               startDay = minDate.getSolarDay;
    }
    if ((year == maxDate.getSolarYear) && (month == maxDate.getSolarMonth)) {
               endDay = maxDate.getSolarDay;
    }
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    return tempArr ;
}



+ (NSArray *)getYearArrWithStartYear:(BMDate *)startDate andEndYear:(BMDate *)endDate andTypeOfCalendar:(TypeOfCalendar) typeOfCalendar{
    NSMutableArray *tempArr = [NSMutableArray array];
    if (typeOfCalendar == TypeCalendarAmLich) {
           for (NSInteger i = startDate.getlunarYear; i <= endDate.getlunarYear; i++) {
             [tempArr addObject:[@(i) stringValue]];
         }
    } else {
        for (NSInteger i = startDate.getSolarYear; i <= endDate.getSolarYear; i++) {
            [tempArr addObject:[@(i) stringValue]];
        }
    }
    return tempArr;
}



+ (NSArray *)getMonthArr:(NSInteger)year minDate:(BMDate *)minDate maxDate:(BMDate *)maxDate  andTypeCalendar:(TypeOfCalendar)typeOfCalendar {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMonth - startMonth + 1)];
    
    if (typeOfCalendar == TypeCalendarAmLich) {
        if (year == minDate.getlunarYear) {
            startMonth = minDate.getLunarMonth;
        }
        if (year == maxDate.getlunarYear) {
            endMonth = maxDate.getLunarMonth;
        }
    } else {
        if (year == minDate.getSolarYear) {
            startMonth = minDate.getSolarMonth;
        }
        if (year == maxDate.getSolarYear) {
            endMonth = maxDate.getSolarMonth;
        }
    }
   
    
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    
    if (typeOfCalendar == TypeCalendarAmLich && [BMYear isLeapLunarYear:year]) {
        NSInteger leapMonth = [BMYear getLeapLunarMonth:year];
        NSString *leapMonthStr = [NSString stringWithFormat:@"%tu%@", leapMonth, PLUS];
        if ([leapMonthStr isKindOfClass:NSString.class] && leapMonth <= tempArr.count) {
            [tempArr insertObject:leapMonthStr atIndex:leapMonth];
        }
    }
    return tempArr;
}

+ (NSArray *)getTypeCalendarArr {
    return @[@(TypeCalendarAmLich), @(TypeCalendarDuongLich)];
}

+ (NSInteger)getDaysInSolarYear:(NSInteger)year month:(NSInteger)month{
    Month monthEnum = (Month)month;
    BOOL isLeapYear = [BMYear isLeapSolarYear:year];
    switch (monthEnum) {
        case Thang1:case Thang3:case Thang5:case Thang7:case Thang8:case Thang10:case Thang12: {
            return 31;
            break;
        }
        case Thang4:case Thang6:case Thang9:case Thang11: {
            return 30;
            break;
        }
        case Thang2: {
            if (isLeapYear) {
                return 29;
                break;
            } else {
                return 28;
                break;
            }
        }
        default:
            break;
    }
    return 0;
}


+ (NSInteger)getDaysInLunarYear:(NSInteger)year month:(NSInteger)month isLeapMonth:(BOOL)isLeapMonth {
    
    NSInteger startDayOfMonth = [LunarUtils jdFromLunarDate:1 mm:month yy:year isLunarLeap:isLeapMonth andTimeZone:LOCAL_TIMEZONE];
    
    NSInteger k = floor( 0.5 + (startDayOfMonth  - 2415021.076998695) / 29.530588853);
    
    NSInteger startDayOfNextMonth = [LunarUtils getNewMoonDay:k+1 timeZone:LOCAL_TIMEZONE];
    return startDayOfNextMonth - startDayOfMonth;
}





- (NSString *)getStringMonth:(TypeOfCalendar)typeOfCalendar {
    NSString *month = NSString.new;
    if (typeOfCalendar == TypeCalendarAmLich) {
            if (self.isLeapLunarMonth) {
            month = [NSString stringWithFormat:@"%tu%@",self.getLunarMonth, PLUS];
        } else {
            month = [NSString stringWithFormat:@"%tu",self.getLunarMonth];
        }

    } else {
        month = [NSString stringWithFormat:@"%tu",self.getSolarMonth];

    }
    return month;
}


@end
