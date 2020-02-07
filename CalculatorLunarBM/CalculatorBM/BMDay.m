//
//  BMDay.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMDay.h"
#import "CanChi.h"

@implementation BMDay


+ (NSString*)dayOfVietnamese:(int)day :(int)month :(int)year{
    int CANDay = floor([CanChi universalToJD:day :month :year] + 9.5);
    int CHIDay = floor([CanChi universalToJD:day :month :year] + 1.5);
    return [NSString stringWithFormat:@"%@ %@",CanChi.getThienCan[CANDay % 10],CanChi.getDiaChi[CHIDay % 12]];
}
@end
