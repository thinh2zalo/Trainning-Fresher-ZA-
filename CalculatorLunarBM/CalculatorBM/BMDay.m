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
