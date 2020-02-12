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
@property (assign) NSInteger jdn;



@end
@implementation BMDate


- (instancetype)initDate:(NSString *)date {
    NSArray * dayStrArr = [date componentsSeparatedByString:@"/"];
    NSUInteger day = [dayStrArr[0] integerValue];
    NSUInteger month = [dayStrArr[1] integerValue];
    NSUInteger year = [dayStrArr[2] integerValue];
    return [self initDate:day :month :year];

}
- (instancetype)initDate:(NSInteger)dd :(NSInteger)mm :(NSInteger)yy {
    self = [super init];
    if (self) {
        NSDictionary * _lunarDayInfor = [LunarUtils convertSolar2Lunar:dd mm:mm yy:yy timeZone:LOCAL_TIMEZONE];
           NSNumber * lunarDay = [_lunarDayInfor objectForKey:LUNARDAY];
           NSNumber * lunarMonth = [_lunarDayInfor objectForKey:LUNARMONTH];
           NSNumber * lunarYear = [_lunarDayInfor objectForKey:LUNARYEAR];
           NSNumber * lunarLeep = [_lunarDayInfor objectForKey:LUNARLEAP];
            
           if (SAFE_TYPE(lunarDay, NSNumber) && SAFE_TYPE(lunarMonth, NSNumber) && SAFE_TYPE(lunarYear, NSNumber) && SAFE_TYPE(lunarLeep, NSNumber)) {
               self.day = [[BMDay alloc] initWithSDay:dd andLDay:lunarDay.integerValue];
               self.month = [[BMMonth alloc] initWithSMonth:mm andLMonth:lunarMonth.integerValue];
               self.year = [[BMYear alloc] initWithSYear:yy andLYear:lunarYear.integerValue];
               self.jdn = [LunarUtils jdFromDate:dd mm:mm yy:yy];
               
           }
    }
   
    return self;
}

- (NSString*)getNgayCanChi {
    NSInteger CANDay = floor(self.jdn + 9.5);
    NSInteger CHIDay = floor(self.jdn + 1.5);
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[CANDay % 10],LunarUtils.getDiaChi[CHIDay % 12]];
}

- (NSString *)getThangCanChi {
    NSInteger CANDay = (self.year.lunarYear * 12 + self.month.lunarMonth + 3) % 10;
    return [NSString stringWithFormat:@"%@ %@",LunarUtils.getThienCan[CANDay % 10], LunarUtils.getDiaChi[(self.month.lunarMonth + 1) % 12]];
    
}

- (NSString *)getNamCanChi {
    return [self.year namCanChi];
}
- (NSInteger)getLunarDay {
    return self.day.lunarDay;
}

-(NSInteger)getLunarMonth {
    return self.month.lunarMonth;
}

-(NSInteger)getlunarYear {
    return self.year.lunarYear;
}

- (NSString*)dayOfWeek{
    int X = floor(self.jdn + 2.5);
    if (X%7 == 0 ) return @"Thứ bảy";
    if (X%7 == 1 ) return @"Chủ nhật";
    if (X%7 == 2 ) return @"Thứ hai";
    if (X%7 == 3 ) return @"Thứ ba";
    if (X%7 == 4 ) return @"Thứ tư";
    if (X%7 == 5 ) return @"Thứ năm";
    if (X%7 == 6 ) return @"Thứ sáu";
    return @"Chủ nhật";
}





@end
