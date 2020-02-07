//
//  BMYear.m
//  CalculatorBM
//
//  Created by vincent on 2/6/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMYear.h"
#import "CanChi.h"
@implementation BMYear


+ (NSString*)yearOfVietnames:(int)year{
    return [NSString stringWithFormat:@"%@ %@",CanChi.getThienCan[(year + 6) % 10] , CanChi.getDiaChi[(year + 8) % 12]];;
}

+(BOOL)isLeapLunarYear:(int)lYear {
    int a11 = [CanChi getLunarMonth11:lYear timeZone:LOCAL_TIMEZONE];
    int b11 = [CanChi getLunarMonth11:lYear - 1 timeZone:LOCAL_TIMEZONE];
   
    if (a11 - b11 > 365) {
        return true;
    }
    return false;
}

+ (int)getLeapMonthOffset:(int)a11 timeZone:(int)timeZone {
    int k, last, arc, i;
    k = floor((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = [CanChi getSunLongitude:[CanChi getNewMoonDay:k+i timeZone:timeZone ] timeZone:timeZone ];
    do {
        last = arc;
        i++;
        arc = [CanChi getSunLongitude:[CanChi getNewMoonDay:k+i timeZone:timeZone ] timeZone:timeZone ];
    } while (arc != last && i < 14);
    return i-1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
