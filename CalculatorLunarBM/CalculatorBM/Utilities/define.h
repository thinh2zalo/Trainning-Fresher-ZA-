//
//  define.h
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#ifndef define_h
#define define_h
#define LUNARDAY @"lunarDay"
#define LUNARMONTH @"lunarMonth"
#define LUNARYEAR @"lunarYear"
#define LUNARLEAP @"lunaLeap"
#define LOCAL_TIMEZONE 7

#define HEIGHT_SCREEN [[UIScreen mainScreen] bounds].size.height
#define WITDTH_SCREEN [[UIScreen mainScreen] bounds].size.width
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define AMLICH @"Âm"
#define DUONGLICH @"Dương Lịch"
#define STARTYEAR 1904
#define STARTMONTH 1
#define STARTDAY 1
#define DAYFORMAT @"dd/mm/yyyy"
#define ENDYEAR 2099
#define ENDMONTH 12
#define ENDDAY 31
#define PLUS @"+"

// define dayOfWeek
#define THU2 @"Thứ Hai"
#define THU3 @"Thứ Ba"
#define THU4 @"Thứ Tư"
#define THU5 @"Thứ Năm"
#define THU6 @"Thứ Sáu"
#define THU7 @"Thứ Bảy"
#define CHUNHAT @"Chủ Nhật"


typedef NS_ENUM(NSUInteger, TypeOfColumnPicker) {
    ColumnTypeCalendar = 0,
    ColumnDay = 1,
    ColumnMonth = 2,
    ColumnYear = 3
};

typedef NS_ENUM(NSUInteger, TypeOfCalendar) {
    TypeCalendarAmLich,
    TypeCalendarDuongLich
};

typedef NS_ENUM(NSUInteger, Month) {
    Thang1 = 1,
    Thang2 = 2,
    Thang3 = 3,
    Thang4 = 4,
    Thang5 = 5,
    Thang6 = 6,
    Thang7 = 7,
    Thang8 = 8,
    Thang9 = 9,
    Thang10 = 10,
    Thang11 = 11,
    Thang12 = 12
};
#define SAFE_TYPE(OBJECT, TYPE) [OBJECT isKindOfClass:[TYPE class]]


#endif /* define_h */
