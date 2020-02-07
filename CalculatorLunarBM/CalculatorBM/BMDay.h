//
//  BMDay.h
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDay : NSObject
@property (assign) NSUInteger DayLunar;
@property (assign) NSUInteger DaySolar;
+ (NSString*)dayOfVietnamese:(int)day :(int)month :(int)year;
@end

NS_ASSUME_NONNULL_END
