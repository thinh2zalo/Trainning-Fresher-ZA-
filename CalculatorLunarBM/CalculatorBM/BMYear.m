//
//  BMYear.m
//  CalculatorBM
//
//  Created by vincent on 2/6/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMYear.h"

#import "LunarUtils.h"
#import "BMDate.h"
@implementation BMYear

- (instancetype)initWithSolarDay:(NSInteger)solarDay solarMonth:(NSInteger)solarMonth solarYear:(NSInteger)solarYear timeZone:(NSInteger)timeZone {
    
    if (![BMDate validDate:solarDay month:solarMonth year:solarYear]) {
        return nil;
    }
    self = [super init];
      if (self) {
          self.solarYear = solarYear;
          self.lunarYear = [LunarUtils getLunarYearWithSolarDate:solarDay mm:solarMonth yy:solarYear timeZone:timeZone];
      }
      return self;
}

- (instancetype)initWithLunarDay:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth solarYear:(NSInteger)lunarYear isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone {
// check input
    self = [super init];
    if (self) {
        self.lunarYear = lunarYear;
        self.solarYear = [LunarUtils getSolarYearWithLunarDate:lunarDay mm:lunarMonth yy:lunarYear isLeapMonth:isLeapMonth timeZone:timeZone];
    }
    return self;
}


- (BMYear *)initWithSYear:(NSInteger)sMonth {
    return  [self initWithSYear:sMonth andLYear:0];
}

- (BMYear *)initWithSYear:(NSInteger)sMonth andLYear:(NSInteger)lMonth {
    self = [super init];
    if (self) {
        self.solarYear = sMonth;
        self.lunarYear = lMonth;
    }
    return self;
}

- (BOOL)isLeapLunarYear {
    return [BMYear isLeapLunarYear:self.lunarYear];
}

-(BOOL)isLeapSolarYear {
    return [BMYear isLeapSolarYear:self.solarYear];
}

- (NSString*)namCanChi {
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[(self.lunarYear + 6) % 10] , LunarUtils.getDiaChi[(self.lunarYear + 8) % 12]];;
}

// class method
+ (BOOL)isLeapSolarYear:(NSInteger)solarYear {
     BOOL isLeapYear = false;
       if ((solarYear % 4 == 0 && solarYear % 100 != 0) || ( solarYear % 400 == 0 )) {
           isLeapYear = true;
       }
       return isLeapYear;
}


+ (BOOL)isLeapLunarYear:(NSInteger)lYear {
    NSInteger a11 = [LunarUtils getLunarMonth11:lYear timeZone:LOCAL_TIMEZONE];
    NSInteger b11 = [LunarUtils getLunarMonth11:lYear - 1 timeZone:LOCAL_TIMEZONE];
    NSInteger offset = [LunarUtils getLeapMonthOffset:a11 timeZone:LOCAL_TIMEZONE];
    if (a11 - b11 > 365 || offset <= 2) {
        return true;
    }
    
    return false;
}



+ (NSInteger)getLeapLunarMonth:(NSInteger)yy {
    if ([self isLeapLunarYear:yy]) {
        NSInteger a11 = [LunarUtils getLunarMonth11:yy timeZone:LOCAL_TIMEZONE]; // ngay dau tien cuar thang chua  dong tri cua nam yy
        NSInteger b11 = [LunarUtils getLunarMonth11:yy - 1 timeZone:LOCAL_TIMEZONE]; // ngay dau tien cua thang chua dong tri cua nam truoc do yy - 1
        NSInteger offsetA11 = [LunarUtils getLeapMonthOffset:a11 timeZone:LOCAL_TIMEZONE];
        NSInteger offsetB11 = [LunarUtils getLeapMonthOffset:b11 timeZone:LOCAL_TIMEZONE];
        if (offsetA11 < 3 ) {
            return 12 - offsetA11;
        } else {
           return  offsetB11 - 2;
        }
    }
    return -1;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
