//
//  CanChi.h
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//
#import <Foundation/Foundation.h>
#define LOCAL_TIMEZONE 7
#define PI 3.1415926535897932
@interface LunarUtils : NSObject {

}
+ (NSArray *)getDiaChi;
+ (NSArray *)getThienCan;
+ (double)NewMoon:(int)k;
+ (double)SunLongitude:(double)jdn;


// convert lunar to solar
+(NSMutableArray*) convertLunar2Solar:(int)lunarDay lunarMonth:(int)lunarMonth lunarYear:(int)lunarYear lunarLeap:(int)lunarLeap timeZone:(int)timeZone;
// convert solar to lunar

+(NSMutableArray*) convertSolar2Lunar:(int)dd mm:(int)mm yy:(int)yy timeZone:(int)timeZone;
+(int)jdFromDate:(int)dd mm:(int)mm yy:(int)yy;
+(NSMutableArray*)jdToDate:(int)jd;

+(int)getNewMoonDay:(int)k timeZone:(int)timeZone;
+(int)getSunLongitude:(int)jdn timeZone:(int)timeZone;
+(int)getLeapMonthOffset:(int)a11 timeZone:(int)timeZone;
+(int)getLunarMonth11:(int)yy timeZone:(int)timeZone;




@end

