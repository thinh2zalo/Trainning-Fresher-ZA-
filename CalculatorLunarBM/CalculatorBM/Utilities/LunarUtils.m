//
//  CanChi.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "LunarUtils.h"
@interface LunarUtils ()

@end

@implementation LunarUtils
+ (NSMutableDictionary*)getHoroscopeDayInfo:(int)D :(int)M :(int)Y{
    NSMutableDictionary *dayInfo = [[NSMutableDictionary alloc] init];
    [dayInfo setObject:[NSString stringWithFormat:@"%d",D] forKey:@"Day"];
    [dayInfo setObject:[NSString stringWithFormat:@"%d",M] forKey:@"Month"];
    [dayInfo setObject:[NSString stringWithFormat:@"%d",Y] forKey:@"Year"];    
     return dayInfo;
}

+ (NSArray *)getDiaChi {
    static NSArray *diaChi;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       diaChi = @[@"Tý", @"Sửu", @"Dần", @"Mão", @"Thìn", @"Tị", @"Ngọ", @"Mùi", @"Thân", @"Dậu", @"Tuất", @"Hợi"];
    });
    return diaChi;
}

+ (NSArray *)getThienCan {
    static NSArray *thienCan;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       thienCan =  @[@"Giáp", @"Ất", @"Bính", @"Đinh", @"Mậu", @"Kỷ", @"Canh", @"Tân", @"Nhâm", @"Quý"];
    });
    return thienCan;
}

+ (double)NewMoon:(NSInteger)k{
    double T = k/1236.85; // Time in Julian centuries from 1900 January 0.5
    double T2 = T * T;
    double T3 = T2 * T;
    double dr = PI/180;
    double Jd1 = 2415020.75933 + 29.53058868*k + 0.0001178*T2 - 0.000000155*T3;
    Jd1 = Jd1 + 0.00033*sin((166.56 + 132.87*T - 0.009173*T2)*dr); // Mean new moon
    double M = 359.2242 + 29.10535608*k - 0.0000333*T2 - 0.00000347*T3; // Sun's mean anomaly
    double Mpr = 306.0253 + 385.81691806*k + 0.0107306*T2 + 0.00001236*T3; // Moon's mean anomaly
    double F = 21.2964 + 390.67050646*k - 0.0016528*T2 - 0.00000239*T3; // Moon's argument of latitude
    double C1=(0.1734 - 0.000393*T)*sin(M*dr) + 0.0021*sin(2*dr*M);
    C1 = C1 - 0.4068*sin(Mpr*dr) + 0.0161*sin(dr*2*Mpr);
    C1 = C1 - 0.0004*sin(dr*3*Mpr);
    C1 = C1 + 0.0104*sin(dr*2*F) - 0.0051*sin(dr*(M+Mpr));
    C1 = C1 - 0.0074*sin(dr*(M-Mpr)) + 0.0004*sin(dr*(2*F+M));
    C1 = C1 - 0.0004*sin(dr*(2*F-M)) - 0.0006*sin(dr*(2*F+Mpr));
    C1 = C1 + 0.0010*sin(dr*(2*F-Mpr)) + 0.0005*sin(dr*(2*Mpr+M));
    double deltat;
    if (T < -11) {
        deltat= 0.001 + 0.000839*T + 0.0002261*T2 - 0.00000845*T3 - 0.000000081*T*T3;
    } else {
        deltat= -0.000278 + 0.000265*T + 0.000262*T2;
    };
    double JdNew = Jd1 + C1 - deltat;
    return JdNew;
}

+ (double)SunLongitude:(double)jdn{
    double T = (jdn - 2451545.0 ) / 36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    double T2 = T*T;
    double dr = PI/180; // degree to radian
    double M = 357.52910 + 35999.05030*T - 0.0001559*T2 - 0.00000048*T*T2; // mean anomaly, degree
    double L0 = 280.46645 + 36000.76983*T + 0.0003032*T2; // mean longitude, degree
    double DL = (1.914600 - 0.004817*T - 0.000014*T2)*sin(dr*M);
    DL = DL + (0.019993 - 0.000101*T)*sin(dr*2*M) + 0.000290*sin(dr*3*M);
    double L = L0 + DL; // true longitude, degree
    L = L*dr;
    L = L - PI*2*(floor(L/(PI*2))); // Normalize to (0, 2*PI)
    return L;
}

+ (NSInteger)jdFromDate:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy {
    NSInteger a, y, m, jd;
    a = floor((14 - mm) / 12);
    y = yy+4800-a;
    m = mm+12*a-3;
    jd = dd + floor((153*m+2)/5) + 365*y + floor(y/4) - floor(y/100) + floor(y/400) - 32045;
    if (jd < 2299161) {
        jd = dd + floor((153*m+2)/5) + 365*y + floor(y/4) - 32083;
    }    return jd;
}

+(NSMutableArray*)jdToDate:(NSInteger)jd {
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    NSInteger a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) { // After 5/10/1582, Gregorian calendar
        a = jd + 32044;
        b = floor((4*a+3)/146097);
        c = a - floor((b*146097)/4);
    } else {
        b = 0;
        c = jd + 32082;
    }
    d = floor((4*c+3)/1461);
    e = c - floor((1461*d)/4);
    m = floor((5*e+2)/153);
    day = e - floor((153*m+2)/5) + 1;
    month = m + 3 - 12*floor(m/10);
    year = b*100 + d - 4800 + floor(m/10);
    [arr addObject:[NSNumber numberWithDouble:day]];
    [arr addObject:[NSNumber numberWithDouble:month]];
    [arr addObject:[NSNumber numberWithDouble:year]];
    return arr;
}

+ (double)newMoonDay:(NSInteger)k {
    double T, T2, T3, dr, Jd1, M, Mpr, F, C1, deltat,JdNew;
    
    T = k/1236.85; // Time in Julian centuries from 1900 January 0.5
    T2 = T * T;
    T3 = T2 * T;
    dr = PI/180;
    Jd1 = 2415020.75933 + 29.53058868*k + 0.0001178*T2 - 0.000000155*T3;
    Jd1 = Jd1 + 0.00033*sin((166.56 + 132.87*T - 0.009173*T2)*dr); // Mean new moon
    M = 359.2242 + 29.10535608*k - 0.0000333*T2 - 0.00000347*T3; // Sun's mean anomaly
    Mpr = 306.0253 + 385.81691806*k + 0.0107306*T2 + 0.00001236*T3; // Moon's mean anomaly
    F = 21.2964 + 390.67050646*k - 0.0016528*T2 - 0.00000239*T3; // Moon's argument of latitude
    C1=(0.1734 - 0.000393*T)*sin(M*dr) + 0.0021*sin(2*dr*M);
    C1 = C1 - 0.4068*sin(Mpr*dr) + 0.0161*sin(dr*2*Mpr);
    C1 = C1 - 0.0004*sin(dr*3*Mpr);
    C1 = C1 + 0.0104*sin(dr*2*F) - 0.0051*sin(dr*(M+Mpr));
    C1 = C1 - 0.0074*sin(dr*(M-Mpr)) + 0.0004*sin(dr*(2*F+M));
    C1 = C1 - 0.0004*sin(dr*(2*F-M)) - 0.0006*sin(dr*(2*F+Mpr));
    C1 = C1 + 0.0010*sin(dr*(2*F-Mpr)) + 0.0005*sin(dr*(2*Mpr+M));
    if (T < -11) {
        deltat= 0.001 + 0.000839*T + 0.0002261*T2 - 0.00000845*T3 - 0.000000081*T*T3;
    } else {
        deltat= -0.000278 + 0.000265*T + 0.000262*T2;
    };
    JdNew = Jd1 + C1 - deltat;
    return JdNew ;
    
}

+ (NSInteger)getNewMoonDay:(NSInteger)k timeZone:(NSInteger)timeZone {
    return  floor([self newMoonDay:k] + 0.5 +  (float)timeZone/24) ;
}
+(NSInteger)getSunLongitude:(NSInteger)jdn timeZone:(NSInteger)timeZone {
    return floor([self sunLongitude:(jdn - 0.5 -  (float)timeZone/24)]/ PI*6);
}

+(double)sunLongitude:(double)jdn {
    double T, T2, dr, M, L0, DL, L;
//    T = (jdn - 2451545.5 - timeZone/24) / 36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T = (jdn - 2451545.0 ) / 36525;
    T2 = T*T;
    dr =  PI/180; // degree to radian
    M = 357.52910 + 35999.05030*T - 0.0001559*T2 - 0.00000048*T*T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983*T + 0.0003032*T2; // mean longitude, degree
    DL = (1.914600 - 0.004817*T - 0.000014*T2)*sin(dr*M);
    DL = DL + (0.019993 - 0.000101*T)*sin(dr*2*M) + 0.000290*sin(dr*3*M);
    L = L0 + DL; // true longitude, degree
    L = L*dr;
    L = L - PI*2*(floor(L/(PI*2))); // Normalize to (0, 2*PI)
    return L;
}

+(NSInteger)getLeapMonthOffset:(NSInteger)a11 timeZone:(NSInteger)timeZone {
    NSInteger k, last, arc, i;
    k = floor((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = [self getSunLongitude:[self getNewMoonDay:k+i timeZone:timeZone ] timeZone:timeZone ];
    do {
        last = arc;
        i++;
        arc = [self getSunLongitude:[self getNewMoonDay:k+i timeZone:timeZone ] timeZone:timeZone ];
    } while (arc != last && i < 14);
    return i-1;
}


+ (NSInteger)getLunarMonth11:(NSInteger)yy timeZone:(NSInteger)timeZone {
    NSInteger k, off, nm, sunLong;
    off = [self jdFromDate:31 mm:12 yy:yy] - 2415021;
    k = floor(off / 29.530588853);
    nm = [self getNewMoonDay:k timeZone:7];
    sunLong = [self getSunLongitude:nm timeZone:timeZone]; // sun longitude at local midnight
    if (sunLong >= 9) {
        nm = [self getNewMoonDay:k-1 timeZone:timeZone];
    }
    return nm;
}

+ (NSInteger)getMonthStart:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone{
    NSInteger k, dayNumber, monthStart;
       dayNumber = [self jdFromDate:dd mm:mm yy:yy];
       k = floor((dayNumber - 2415021.076998695) / 29.530588853);
       monthStart = [self getNewMoonDay:k+1 timeZone:timeZone];
       if (monthStart > dayNumber) {
           monthStart = [self getNewMoonDay:k timeZone:timeZone];
       }
    return monthStart;
}

+ (NSInteger)getLunarDayWithSolarDate:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone{
    NSInteger lunarDay, dayNumber, monthStart;
    dayNumber = [self jdFromDate:dd mm:mm yy:yy];
    monthStart = [self getMonthStart:dd mm:mm yy:yy timeZone:timeZone];
    lunarDay = dayNumber-monthStart+1;
    return  lunarDay;
}

+ (NSInteger)getSolarDayWithLunarDate:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone{
    NSArray *resultSolarDate = [self convertLunarToSolar:dd lunarMonth:mm lunarYear:yy lunarLeap:isLeapMonth timeZone:timeZone];
    return [resultSolarDate[0] integerValue];
}

+ (NSInteger)getSolarMonthWithLunarDate:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone{
    NSArray *resultSolarDate = [self convertLunarToSolar:dd lunarMonth:mm lunarYear:yy lunarLeap:isLeapMonth timeZone:timeZone];
    return [resultSolarDate[1] integerValue];
}

+ (NSInteger)getSolarYearWithLunarDate:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone{
    NSArray *resultSolarDate = [self convertLunarToSolar:dd lunarMonth:mm lunarYear:yy lunarLeap:isLeapMonth timeZone:timeZone];
    return [resultSolarDate[2] integerValue];
}


+ (NSInteger)getLunarMonthWithDateSolar:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone{
    NSInteger  monthStart, a11, b11, diff, leapMonthDiff, lunarMonth, lunarLeap;
    monthStart = [self getMonthStart:dd mm:mm yy:yy timeZone:timeZone];

    a11 = [self getLunarMonth11:yy timeZone:timeZone];
    b11 = a11;
    if (a11 >= monthStart) {
        a11 = [self getLunarMonth11:yy-1 timeZone:timeZone];
    } else {
        b11 = [self getLunarMonth11:yy+1 timeZone:timeZone];
    }
    diff = floor((monthStart - a11)/29);
    lunarLeap = 0;
    lunarMonth = diff+11;
    if (b11 - a11 > 365) {
        leapMonthDiff = [self getLeapMonthOffset:a11 timeZone:7];
        if (diff >= leapMonthDiff) {
            lunarMonth = diff + 10;
            if (diff == leapMonthDiff) {
                lunarLeap = 1;
            }
        }
    }
    if (lunarMonth > 12) {
        lunarMonth = lunarMonth - 12;
    }
    return lunarMonth;
}

+ (NSInteger )getLunarYearWithDateSolar:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone {
    NSInteger  monthStart, a11, b11, diff, lunarMonth, lunarYear, leapMonthDiff;
         monthStart = [self getMonthStart:dd mm:mm yy:yy timeZone:timeZone];
      lunarMonth = [self getLunarMonthWithDateSolar:dd mm:mm yy:yy timeZone:timeZone];
    
      a11 = [self getLunarMonth11:yy timeZone:timeZone];
    b11 = a11;

      if (a11 >= monthStart) {
          lunarYear = yy;
          a11 = [self getLunarMonth11:yy-1 timeZone:timeZone];
            
      } else {
          lunarYear = yy+1;
          b11 = [self getLunarMonth11:yy+1 timeZone:timeZone];

      }
    diff = floor((monthStart - a11)/29);
    lunarMonth = diff+11;
    if (b11 - a11 > 365) {
         leapMonthDiff = [self getLeapMonthOffset:a11 timeZone:7];
         if (diff >= leapMonthDiff) {
             lunarMonth = diff + 10;
            
         }
     }
      
      if (lunarMonth > 12) {
          lunarMonth = lunarMonth - 12;
      }
      if (lunarMonth >= 11 && diff < 4) {
          lunarYear -= 1;
      }
    return lunarYear;
}

+(BOOL)isLeapMonth:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone {
    NSInteger k, dayNumber, monthStart, a11, b11, diff, leapMonthDiff, lunarDay, lunarMonth, lunarYear, lunarLeap;
      dayNumber = [self jdFromDate:dd mm:mm yy:yy];
      k = floor((dayNumber - 2415021.076998695) / 29.530588853);
      monthStart = [self getNewMoonDay:k+1 timeZone:timeZone];
      if (monthStart > dayNumber) {
          monthStart = [self getNewMoonDay:k timeZone:timeZone];
      }
      a11 = [self getLunarMonth11:yy timeZone:timeZone];
      b11 = a11;
      if (a11 >= monthStart) {
          lunarYear = yy;
          a11 = [self getLunarMonth11:yy-1 timeZone:timeZone];
      } else {
          lunarYear = yy+1;
          b11 = [self getLunarMonth11:yy+1 timeZone:timeZone];
      }
      lunarDay = dayNumber-monthStart+1;
      diff = floor((monthStart - a11)/29);
      lunarLeap = 0;
      lunarMonth = diff+11;
      if (b11 - a11 > 365) {
          leapMonthDiff = [self getLeapMonthOffset:a11 timeZone:7];
          if (diff >= leapMonthDiff) {
              lunarMonth = diff + 10;
              if (diff == leapMonthDiff) {
                  lunarLeap = 1;
              }
          }
      }
    return lunarLeap;
}


+ (NSMutableDictionary *)convertSolarToLunar:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone {
   
    NSInteger k, dayNumber, monthStart, a11, b11, diff, leapMonthDiff, lunarDay, lunarMonth, lunarYear, lunarLeap;
    dayNumber = [self jdFromDate:dd mm:mm yy:yy];
    k = floor((dayNumber - 2415021.076998695) / 29.530588853);
    monthStart = [self getNewMoonDay:k+1 timeZone:timeZone];
    if (monthStart > dayNumber) {
        monthStart = [self getNewMoonDay:k timeZone:timeZone];
    }
    a11 = [self getLunarMonth11:yy timeZone:timeZone];
    b11 = a11;
    if (a11 >= monthStart) {
        lunarYear = yy;
        a11 = [self getLunarMonth11:yy-1 timeZone:timeZone];
    } else {
        lunarYear = yy+1;
        b11 = [self getLunarMonth11:yy+1 timeZone:timeZone];
    }
    lunarDay = dayNumber-monthStart+1;
    diff = floor((monthStart - a11)/29);
    lunarLeap = 0;
    lunarMonth = diff+11;
    if (b11 - a11 > 365) {
        leapMonthDiff = [self getLeapMonthOffset:a11 timeZone:7];
        if (diff >= leapMonthDiff) {
            lunarMonth = diff + 10;
            if (diff == leapMonthDiff) {
                lunarLeap = 1;
            }
        }
    }
    if (lunarMonth > 12) {
        lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
        lunarYear -= 1;
    }
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:lunarDay] forKey:LUNARDAY];
    [dict setObject:[NSNumber numberWithInteger:lunarMonth] forKey:LUNARMONTH];
    [dict setObject:[NSNumber numberWithInteger:lunarYear] forKey:LUNARYEAR];
    [dict setObject:[NSNumber numberWithInteger:lunarLeap] forKey:LUNARLEAP];
    
    return dict;
}

+(NSMutableArray*) convertLunarToSolar:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth lunarYear:(NSInteger)lunarYear lunarLeap:(NSInteger)lunarLeap timeZone:(NSInteger)timeZone {
    
    double k, a11, b11, off, leapOff, leapMonth, monthStart;
    NSInteger jd;
    if (lunarMonth < 11) {
        a11 = [self getLunarMonth11:lunarYear-1 timeZone:timeZone];
        b11 = [self getLunarMonth11:lunarYear timeZone:timeZone];
    } else {
        a11 = [self getLunarMonth11:lunarYear timeZone:timeZone];
        b11 = [self getLunarMonth11:lunarYear+1 timeZone:timeZone];
    }
    off = lunarMonth - 11;
    if (off < 0) {
        off = off + 12;
    }
    if (b11 - a11 > 365) {
        leapOff = [self getLeapMonthOffset:a11 timeZone:timeZone];
        leapMonth = leapOff - 2;
        if (leapMonth < 0) {
            leapMonth += 12;
        }
        if (lunarLeap != 0 && lunarMonth != leapMonth) {
        } else if (lunarLeap != 0 || off >= leapOff) {
            off += 1;
        }
    }
    k = floor(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    monthStart = [self getNewMoonDay:k+off timeZone:timeZone];
    jd=monthStart+lunarDay-1;
    return [self jdToDate:jd];
}


@end
