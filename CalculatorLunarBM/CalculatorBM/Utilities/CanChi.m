//
//  CanChi.m
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "CanChi.h"

@implementation CanChi
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

+(int)getSunLongitude:(int)jdn timeZone:(int)timeZone
{
    double T, T2, dr, M, L0, DL, L;
    //T = (jdn - 2451545.5 - timeZone/24) / 36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T = (jdn - 2451545.0 ) / 36525;
    T2 = T*T;
    dr = PI/180; // degree to radian
    M = 357.52910 + 35999.05030*T - 0.0001559*T2 - 0.00000048*T*T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983*T + 0.0003032*T2; // mean longitude, degree
    DL = (1.914600 - 0.004817*T - 0.000014*T2)*sin(dr*M);
    DL = DL + (0.019993 - 0.000101*T)*sin(dr*2*M) + 0.000290*sin(dr*3*M);
    L = L0 + DL; // true longitude, degree
    L = L*dr;
    L = L - PI*2*(floor(L/(PI*2))); // Normalize to (0, 2*PI)
    return floor(L / PI * 6);
}

+(int)getLunarMonth11:(int)yy timeZone:(int)timeZone
{
    int k, off, nm, sunLong;
    off = [self jdFromDate:31 mm:12 yy:yy] - 2415021;
    k = floor(off / 29.530588853);
    nm = [self getNewMoonDay:k timeZone:timeZone];
    sunLong = [self getSunLongitude:nm timeZone:timeZone];
    if (sunLong >= 9) {
        nm = [self getNewMoonDay:k-1 timeZone:timeZone];
    }
    return nm;
}

+ (double)universalToJD:(int)day :(int)month :(int)year {
    
    double jD;
    
    if (year > 1582 || (year == 1582 && month > 10) || (year == 1582 && month == 10 && day > 14)) {
        jD = 367*year - floor(7*(year+floor((month+9)/12))/4) - floor(3*(floor((year+(month-9)/7)/100)+1)/4) + floor(275*month/9)+day+1721028.5;
    } else {
        jD = 367*year - floor(7*(year+5001+floor((month-9)/7))/4) + floor(275*month/9)+day+1729776.5;
    }
    return jD;
    
}


+(int)jdFromDate:(int)dd mm:(int)mm yy:(int)yy
{
    int a, y, m, jd;
    a = floor((14 - mm) / 12);
    y = yy+4800-a;
    m = mm+12*a-3;
    jd = dd + floor((153*m+2)/5) + 365*y + floor(y/4) - floor(y/100) + floor(y/400) - 32045;
    if (jd < 2299161) {
        jd = dd + floor((153*m+2)/5) + 365*y + floor(y/4) - 32083;
    }    return jd;
}

+(NSMutableArray*)jdToDate:(int)jd
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    int a, b, c, d, e, m, day, month, year;
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

+(int)getNewMoonDay:(int)k timeZone:(int)timeZone {
    double T, T2, T3, dr, Jd1, M, Mpr, F, C1, deltat,JdNew;
    
    T = k/1236.85; // tính từ 1900
    T2 = T * T;
    T3 = T2 * T;
    dr = PI/180;
    Jd1 = 2415020.75933 + 29.53058868*k + 0.0001178*T2 - 0.000000155*T3;
    Jd1 = Jd1 + 0.00033*sin((166.56 + 132.87*T - 0.009173*T2)*dr);
    M = 359.2242 + 29.10535608*k - 0.0000333*T2 - 0.00000347*T3;
    Mpr = 306.0253 + 385.81691806*k + 0.0107306*T2 + 0.00001236*T3;
    F = 21.2964 + 390.67050646*k - 0.0016528*T2 - 0.00000239*T3;
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
    return floor(JdNew + 0.5 + timeZone/24.0);
}



@end
