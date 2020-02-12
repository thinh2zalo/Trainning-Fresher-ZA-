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

@end
@implementation BMDate

- (instancetype)initDate:(int)dd :(int)mm :(int)yy {
    NSArray * _lunarDayInfor = [LunarUtils ]
    self.day = [[BMDay alloc]initWithSDay:dd];
    self.month = [[BMMonth alloc]initWithSMonth:mm];
    self.year = [[BMYear alloc] initWithSYear:yy];

    return self;
}

@end
