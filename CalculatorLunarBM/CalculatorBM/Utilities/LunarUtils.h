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
#import "define.h"

@interface LunarUtils : NSObject {

}
+ (NSArray *)getDiaChi;
+ (NSArray *)getThienCan;
+ (double)NewMoon:(NSInteger)k;
+ (double)SunLongitude:(double)jdn;


// convert lunar to solar
+(NSMutableArray*) convertLunar2Solar:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth lunarYear:(NSInteger)lunarYear lunarLeap:(NSInteger)lunarLeap timeZone:(NSInteger)timeZone;
// convert solar to lunar

+(NSMutableDictionary*) convertSolar2Lunar:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy timeZone:(NSInteger)timeZone;
+(NSInteger)jdFromDate:(NSInteger)dd mm:(NSInteger)mm yy:(NSInteger)yy;
+(NSMutableArray*)jdToDate:(NSInteger)jd;

+(NSInteger)getNewMoonDay:(NSInteger)k timeZone:(NSInteger)timeZone;
+(NSInteger)getSunLongitude:(NSInteger)jdn timeZone:(NSInteger)timeZone;
+(NSInteger)getLeapMonthOffset:(NSInteger)a11 timeZone:(NSInteger)timeZone;
+(NSInteger)getLunarMonth11:(NSInteger)yy timeZone:(NSInteger)timeZone;




@end

