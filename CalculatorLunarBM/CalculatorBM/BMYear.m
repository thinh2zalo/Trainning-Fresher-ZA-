//
//  BMYear.m
//  CalculatorBM
//
//  Created by vincent on 2/6/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMYear.h"
#import "LunarUtils.h"
@implementation BMYear


- (NSString*)namCanChi {
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[(self.lunarYear + 6) % 10] , LunarUtils.getDiaChi[(self.lunarYear + 8) % 12]];;
}

+ (BOOL)isLeapLunarYear:(NSInteger)lYear {
    NSInteger a11 = [LunarUtils getLunarMonth11:lYear timeZone:LOCAL_TIMEZONE];
    NSInteger b11 = [LunarUtils getLunarMonth11:lYear - 1 timeZone:LOCAL_TIMEZONE];

    if (a11 - b11 > 365) {
        return true;
    }
    return false;
}


+ (NSInteger)getLeapMonth:(NSInteger)yy {
    if ([self isLeapLunarYear:yy]) {
        return [LunarUtils getLeapMonthOffset:yy timeZone:7] - 2;
    }
    return -1;
}

- (BMYear *)initWithSYear:(NSInteger)sMonth{
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
