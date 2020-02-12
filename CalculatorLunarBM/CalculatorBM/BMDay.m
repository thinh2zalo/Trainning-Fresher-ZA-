//
//  BMDay.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMDay.h"
#import "LunarUtils.h"

@implementation BMDay



+ (NSString*)dayOfVietnamese:(int)day :(int)month :(int)year{
    int CANDay = floor([LunarUtils jdFromDate:day mm:month yy:year] + 9.5);
    int CHIDay = floor([LunarUtils jdFromDate:day mm:month yy:year] + 1.5);
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[CANDay % 10],LunarUtils.getDiaChi[CHIDay % 12]];
}

- (NSString*)dayOfWeek:(double)jdDay{
    int X = floor(jdDay + 2.5);
    if (X%7 == 0 ) return @"Thứ bảy";
    if (X%7 == 1 ) return @"Chủ nhật";
    if (X%7 == 2 ) return @"Thứ hai";
    if (X%7 == 3 ) return @"Thứ ba";
    if (X%7 == 4 ) return @"Thứ tư";
    if (X%7 == 5 ) return @"Thứ năm";
    if (X%7 == 6 ) return @"Thứ sáu";
    return @"Chủ nhật";
}


- (BMDay *)initWithSDay:(int)sDay{
    return  [self initWithSDay:sDay andLDay:0];
}

- (BMDay *)initWithSDay:(int)sDay andLDay:(int)lDay {
    self = [super init];
    if (self) {
        self.solarDay = sDay;
        self.lunarDay = lDay;
    }
    return self;
}
@end
