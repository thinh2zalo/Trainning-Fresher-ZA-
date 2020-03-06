//
//  BMDay.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMDay.h"
#import "BMDate.h"
#import "LunarUtils.h"

@implementation BMDay
- (instancetype)initWithSolarDay:(NSInteger)solarDay solarMonth:(NSInteger)solarMonth solarYear:(NSInteger)solarYear timeZone:(NSInteger)timeZone {
    if (![BMDate validDate:solarDay month:solarMonth year:solarYear]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.solarDay = solarDay;
        self.lunarDay = [LunarUtils getLunarDayWithSolarDate:solarDay mm:solarMonth yy:solarYear timeZone:timeZone];
        
    }
    return self;
}

- (instancetype)initWithLunarDay:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth solarYear:(NSInteger)lunarYear isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone {
//    if (![BMDate validDate:lunarDay month:solarMonth year:lunarYear]) {
//        return nil;
//    }
    self = [super init];
    if (self) {
        self.lunarDay = lunarDay;
        self.solarDay = [LunarUtils getSolarDayWithLunarDate:lunarDay mm:lunarMonth yy:lunarYear isLeapMonth:isLeapMonth timeZone:timeZone];
        
    }
    return self;
}

- (BMDay *)initWithSDay:(NSInteger)sDay{
    return  [self initWithSDay:sDay andLDay:0];
}

- (BMDay *)initWithSDay:(NSInteger)sDay andLDay:(NSInteger)lDay {
    self = [super init];
    if (self) {
        self.solarDay = sDay;
        self.lunarDay = lDay;
    }
    return self;
}

@end
