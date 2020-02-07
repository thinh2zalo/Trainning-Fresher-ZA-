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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
