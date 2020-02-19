//
//  BMMonth.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMMonth.h"
#import "LunarUtils.h"
#import "BMDate.h"

@implementation BMMonth

- (instancetype)initWithSolarDay:(NSInteger)solarDay solarMonth:(NSInteger)solarMonth solarYear:(NSInteger)solarYear timeZone:(NSInteger)timeZone {
    if (![BMDate validDate:solarDay month:solarMonth year:solarYear]) {
           return nil;
       }
    self = [super init];
    if (self) {
        self.lunarMonth = [LunarUtils getLunarMonthWithSolarDate:solarDay mm:solarMonth yy:solarYear timeZone:timeZone];
        self.solarMonth = solarMonth;
        
        }
    return self;
}

- (instancetype)initWithLunarDay:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth solarYear:(NSInteger)lunarYear isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone {
    // check input
//    if (![BMDate validDate:lunarDay month:solarMonth year:lunarYear]) {
//        return nil;
//    }
    self = [super init];
    if (self) {
        self.lunarMonth = lunarMonth;
        self.solarMonth = [LunarUtils getSolarMonthWithLunarDate:lunarDay mm:lunarMonth yy:lunarYear isLeapMonth:isLeapMonth timeZone:timeZone];
    }
    return self;
}

- (BMMonth *)initWithSMonth:(NSInteger)sMonth{
    return  [self initWithSMonth:sMonth andLMonth:0];
}

- (BMMonth *)initWithSMonth:(NSInteger)sMonth andLMonth:(NSInteger)lMonth {
    self = [super init];
    if (self) {
        self.solarMonth = sMonth;
        self.lunarMonth = lMonth;
    }
    return self;
}
@end
