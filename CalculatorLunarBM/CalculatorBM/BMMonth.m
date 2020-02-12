//
//  BMMonth.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMMonth.h"
#import "LunarUtils.h"

@implementation BMMonth
+ (NSString*)monthOfVietnames:(NSInteger)lMonth andYear:(NSInteger)lYear{
     int CANDay = (lYear * 12 + lMonth + 3) % 10;
     return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[CANDay % 10], LunarUtils.getDiaChi[(lMonth + 1) % 12]];
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
