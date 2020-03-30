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
#define DUONGLICH @"Dương"
#define STARTYEAR 1904
#define STARTMONTH 1
#define STARTDAY 1
#define DAYFORMAT @"dd/mm/yyyy"
#define ENDYEAR 2099
#define ENDMONTH 12
#define ENDDAY 31
#define PLUS @"+"

#define FILE_QUOTATIONS @"quotations"
#define FILE_URLIMG @"images"
#define TYPEFILE_PLIST @"plist"

// define dayOfWeek
#define THU2 @"T.Hai"
#define THU3 @"T.Ba"
#define THU4 @"T.Tư"
#define THU5 @"T.Năm"
#define THU6 @"T.Sáu"
#define THU7 @"T.Bảy"
#define CHUNHAT @"CN"
#define ShareDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])


typedef NS_ENUM(NSUInteger, NavigationDirection) {
    DirectionNetrue = 0,
    DirectionForword = 1,
    DirectionReverse = 2,
  
};

typedef NS_ENUM(NSUInteger, TypeOfColumnPicker) {
    ColumnTypeCalendar = 0,
    ColumnDay = 1,
    ColumnMonth = 2,
    ColumnYear = 3
};

typedef NS_ENUM(NSUInteger, TypeOfCalendar) {
    TypeCalendarAmLich = 0,
    TypeCalendarDuongLich = 1
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
