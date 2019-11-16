//
//  NSString+CompareTimeStamp.h
//  Step12_17
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#define SECOND  0
#define MINUTE  60
#define HOUSE MINUTE*60
#define DAY HOUSE*24
#define WEEK (DAY*7)
#define MONTH DAY*30
#define YEAR MONTH*12
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, periodTime){
    periodTimeSECOND,
    periodTimeMinute,
    periodTimeHouse,
    periodTimeDay,
    periodTimeWeek,
    periodTimeMonth,
    
};
NS_ASSUME_NONNULL_BEGIN

@interface NSString (CompareTimeStamp)
+(NSString *)convertTimestamp:(NSInteger)timestampInput;
@end

NS_ASSUME_NONNULL_END
