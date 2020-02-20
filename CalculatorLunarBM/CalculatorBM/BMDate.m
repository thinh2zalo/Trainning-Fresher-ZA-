//
//  BMDate.m
//  CalculatorBM
//
//  Created by vincent on 2/11/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMDate.h"
#import "BMYear.h"
#import "BMMonth.h"
#import "BMDay.h"
#import "LunarUtils.h"


@interface BMDate ()
@property (nonatomic, strong)BMDay *day;
@property (nonatomic, strong)BMMonth *month;
@property (nonatomic, strong)BMYear *year;
@property (nonatomic, strong) NSString *dayOfWeek;
@property (assign) NSInteger julianDayNumber;



@end
@implementation BMDate


- (instancetype)initDate:(NSString *)dateStr andTimeZone:(NSInteger)timeZone{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSDate * date = [dateFormatter dateFromString:dateStr];
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    return [self initDateWithSolarDate:components.day :components.month :components.year andTimeZone:timeZone];
}

-  (instancetype)initLocalDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy {
    self = [self initDateWithSolarDate:dd :mm :yy andTimeZone:LOCAL_TIMEZONE];
    if (self) {
        return self;
    }
    return nil;
}

- (instancetype)initDateWithLunarDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy isLeapMonth:(BOOL)isLeapMonth andTimeZone:(NSInteger)timeZone {
    if (![BMDate validDate:dd month:mm year:yy]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.day = [[BMDay alloc] initWithLunarDay:dd lunarMonth:mm solarYear:yy isLeapMonth:isLeapMonth timeZone:timeZone];
        self.month = [[BMMonth alloc] initWithLunarDay:dd lunarMonth:mm solarYear:yy isLeapMonth:isLeapMonth timeZone:timeZone];
        self.year = [[BMYear alloc] initWithLunarDay:dd lunarMonth:mm solarYear:yy isLeapMonth:isLeapMonth timeZone:timeZone];
    }
    return self;
}


- (instancetype)initDateWithSolarDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy andTimeZone:(NSInteger)timeZone{
    if (![BMDate validDate:dd month:mm year:yy]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.day = [[BMDay alloc] initWithSolarDay:dd solarMonth:mm solarYear:yy timeZone:timeZone];
        self.month = [[BMMonth alloc] initWithSolarDay:dd solarMonth:mm solarYear:yy timeZone:timeZone];
        self.year = [[BMYear alloc] initWithSolarDay:dd solarMonth:mm solarYear:yy timeZone:timeZone];
        self.julianDayNumber = [LunarUtils jdFromSolarDate:dd mm:mm yy:yy];
    }
    return self;
}

-(NSInteger)getLeapLunarMonth {
    if ([self isLeapLunarYear]) {
        return [self.year getLeapLunarMonth];
    }
    return -1;
}

- (BOOL)isLeapLunarMonth {
    return [LunarUtils isLeapMonth:self.getSolarDay mm:self.getSolarMonth yy:self.getSolarYear timeZone:LOCAL_TIMEZONE];
}

- (BOOL)isLeapSolarMonth {
    return [self.year isLeapSolarYear];
}

- (NSString*)getNgayCanChi {
    NSInteger CANDay = floor(self.julianDayNumber + 9.5);
    NSInteger CHIDay = floor(self.julianDayNumber + 1.5);
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[CANDay % 10],LunarUtils.getDiaChi[CHIDay % 12]];
}

- (NSString *)getThangCanChi {
    NSInteger CANDay = (self.year.lunarYear * 12 + self.month.lunarMonth + 3) % 10;
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[CANDay % 10], LunarUtils.getDiaChi[(self.month.lunarMonth + 1) % 12]];
}

- (NSString *)getNamCanChi {
    return [self.year namCanChi];
}

- (NSInteger)getLunarDay {
    return self.day.lunarDay;
}

- (NSInteger)getLunarMonth {
    return self.month.lunarMonth;
}

- (NSInteger)getlunarYear {
    return self.year.lunarYear;
}

- (NSInteger)getSolarDay {
    return self.day.solarDay;
}

-(NSInteger)getSolarMonth {
    return self.month.solarMonth;
}

-(NSInteger)getSolarYear {
    return self.year.solarYear;
}

- (BOOL)isLeapLunarYear {
    return [self.year isLeapLunarYear];
}

- (BOOL)isLeapSolarYear {
    return [self.year isLeapSolarYear];
}

- (NSString*)dayOfWeek {
    int X = floor(self.julianDayNumber + 2.5);
    if (X%7 == 0 ) return THU7;
    if (X%7 == 1 ) return CHUNHAT;
    if (X%7 == 2 ) return THU2;
    if (X%7 == 3 ) return THU3;
    if (X%7 == 4 ) return THU4;
    if (X%7 == 5 ) return THU5;
    if (X%7 == 6 ) return THU6;
    return CHUNHAT;
}


+ (BOOL)validDate:(NSInteger)day month:(NSInteger)month year:(NSInteger)year {
    NSString *dateStr = [NSString stringWithFormat:@"%tu/%tu/%tu",day,month,year];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSDate * date = [dateFormatter dateFromString:dateStr];
    if (date) {
        return true;
    }
    return false;
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

-(BOOL)bmDate_compare:(BMDate *)date {
    return self.julianDayNumber >= date.julianDayNumber ? true : false;
}

+ (NSInteger)getDaysInLunarYear:(NSInteger)year month:(NSInteger)month leapMonth:(NSInteger)leapMonth {
    
    NSInteger startDayOfMonth = [LunarUtils jdFromLunarDate:1 mm:month yy:year lunarLeap:leapMonth andTimeZone:LOCAL_TIMEZONE];
  
    NSInteger k = floor( 0.5 + (startDayOfMonth  - 2415021.076998695) / 29.530588853);
           
    NSInteger startDayOfNextMonth = [LunarUtils getNewMoonDay:k+1 timeZone:LOCAL_TIMEZONE];
    return startDayOfNextMonth - startDayOfMonth;
}


//+ (NSUInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month andTypeOfCalendar:(TypeOfCalendar) typeOfCalendar {
//    // check input
//
//    if (typeOfCalendar == TypeCalendarAmLich) {
//        NSInteger k11, dayStartMonth, dayEndMonth , totalDay;
//        NSInteger a11 = [LunarUtils getLunarMonth11:year timeZone:LOCAL_TIMEZONE];
//        k11 = floor((a11 - 2415021.076998695) / 29.530588853);
//
//         dayStartMonth = [LunarUtils getNewMoonDay:k11 - 11 + month - 1 timeZone:LOCAL_TIMEZONE];
//         dayEndMonth =   [LunarUtils getNewMoonDay:k11 - 11 + month timeZone:LOCAL_TIMEZONE];
//         totalDay = dayEndMonth - dayStartMonth;
//        return  totalDay;
//    } else {
//
//    }
//
//}

+ (NSDateComponents *)getCurrentDateComponents {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger units = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian components:units fromDate:[NSDate date]];
}

+ (BMDate *)getCurrentDate {
    BMDate * currentDate  = [[BMDate alloc] initLocalDate:[self getCurrentDateComponents].day :[self getCurrentDateComponents].month  :[self getCurrentDateComponents].year ];
    return currentDate;
    
}

+ (NSArray *) getLunarDayArr:(NSInteger)year month:(NSInteger)month isLeapMonth:(BOOL)isLeapMonth {
    NSInteger startDay = 1;
    NSInteger endDay;
    NSInteger leapMonth = 0;
    if (isLeapMonth) {
         leapMonth  = [BMYear getLeapLunarMonth:year];
    }
    endDay = [BMDate getDaysInLunarYear:year month:month leapMonth:leapMonth];
    NSMutableArray *tempArr = [NSMutableArray array];
       for (NSInteger i = startDay; i <= endDay; i++) {
           [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
       }
       return tempArr;
}

+ (NSArray *) getSolarDayArr:(NSInteger)year month:(NSInteger)month {
    NSInteger startDay = 1;
    NSInteger endDay = [BMDate getDaysInSolarYear:year month:month];
    NSMutableArray *tempArr = [NSMutableArray array];
       for (NSInteger i = startDay; i <= endDay; i++) {
           [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
       }
       return tempArr ;
}

+ (NSArray *)getDayArr:(NSInteger)year month:(NSInteger)month andTypeOfCalendar:(TypeOfCalendar) typeOfCalendar{
    NSInteger startDay = 1;
     NSInteger endDay;
     if (typeOfCalendar == TypeCalendarAmLich) {
         NSInteger leapMonth = 0;
         endDay = [BMDate getDaysInLunarYear:year month:month leapMonth:leapMonth];
     } else {
         endDay = [BMDate getDaysInSolarYear:year month:month];
     }
    
     NSMutableArray *tempArr = [NSMutableArray array];
     for (NSInteger i = startDay; i <= endDay; i++) {
         [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
     }
     return tempArr ;
}

+ (NSArray *)getDayArr:(NSInteger)year month:(NSInteger)month andTypeOfCalendar:(TypeOfCalendar) typeOfCalendar{
    NSInteger startDay = 1;
    NSInteger endDay;
    if (typeOfCalendar == TypeCalendarAmLich) {
        NSInteger leapMonth = 0;
        endDay = [BMDate getDaysInLunarYear:year month:month leapMonth:leapMonth];
    } else {
        endDay = [BMDate getDaysInSolarYear:year month:month];
    }
   
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    return tempArr ;
}

+ (NSArray *)getYearArrWithStartYear:(NSInteger)startYear andEndYear:(NSInteger)endYear {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = startYear; i <= endYear; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    return tempArr;
}

+ (NSArray *)getMonthArr:(NSInteger)year andTypeCalendar:(TypeOfCalendar)typeOfCalendar {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMonth - startMonth + 1)];
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    
    if (typeOfCalendar == TypeCalendarAmLich && [BMYear isLeapLunarYear:year]) {
        NSInteger leapMonth = [BMYear getLeapLunarMonth:year];
        NSString *leapMonthStr = [NSString stringWithFormat:@"%tu+", leapMonth];
        if ([leapMonthStr isKindOfClass:NSString.class] && leapMonth <= tempArr.count) {
             [tempArr insertObject:leapMonthStr atIndex:leapMonth];
        }
    }
    return tempArr;
}

+ (NSArray *)getTypeCalendarArr {
    return @[AMLICH, DUONGLICH];
}


@end
