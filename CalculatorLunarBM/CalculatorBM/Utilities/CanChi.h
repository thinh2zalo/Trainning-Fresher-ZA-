//
//  CanChi.h
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//
#define LOCAL_TIMEZONE 7
#define PI M_PI
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CanChi : NSObject
+(NSArray *)getThienCan;
+(NSArray *)getDiaChi;
+ (double)universalToJD:(int)day :(int)month :(int)year;
+ (int)getLunarMonth11:(int)yy timeZone:(int)timeZone;
+ (int)jdFromDate:(int)dd mm:(int)mm yy:(int)yy;
+  (NSMutableArray*)jdToDate:(int)jd;
+ (int)getNewMoonDay:(int)k timeZone:(int)timeZone;
+ (int)getSunLongitude:(int)jdn timeZone:(int)timeZone;

//+ (BOOL)isValidDate;
@end

NS_ASSUME_NONNULL_END
