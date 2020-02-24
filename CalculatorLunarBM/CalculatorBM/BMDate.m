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
    dateFormatter.dateFormat = DAYFORMAT;
    NSDate * date = [dateFormatter dateFromString:dateStr];
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    return [self initDateWithSolarDate:components.day :components.month :components.year andTimeZone:timeZone];
}

- (instancetype)initLocalDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy {
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

- (NSInteger)getIndexOfMonthInYear:(TypeOfCalendar)typeOfCalendar {
    if (typeOfCalendar == TypeCalendarAmLich) {
        if ((self.isLeapLunarMonth) && (self.getLunarMonth > self.getLeapLunarMonth)) {
               return self.getLunarMonth ;
        } else {
            return self.getLunarMonth - 1;
        }
    } else {
        return self.getSolarMonth - 1;
    }
}


- (NSInteger)getMonthWithTypeCalendar:(TypeOfCalendar)typeOfCalendar {
    if (typeOfCalendar == TypeCalendarAmLich) {
        return [self getLunarMonth];
    }
    return [self getSolarMonth];
}

- (NSInteger)getYearWithTypeCalendar:(TypeOfCalendar)typeOfCalendar {
    if (typeOfCalendar == TypeCalendarAmLich) {
        return [self getlunarYear];
    }
    return [self getSolarYear];
}

- (NSInteger)getDayWithTypeCalendar:(TypeOfCalendar)typeOfCalendar {
    if (typeOfCalendar == TypeCalendarAmLich) {
        return [self getLunarDay];
    }
    return [self getSolarDay];
}
-(BOOL)bmDate_compare:(BMDate *)date {
    return self.julianDayNumber >= date.julianDayNumber ? true : false;
}
@end
