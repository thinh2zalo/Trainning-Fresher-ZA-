//
//  BMYear.h
//  CalculatorBM
//
//  Created by vincent on 2/6/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BMYear : NSObject
@property (assign) NSUInteger yearLunar;
@property (assign) NSUInteger yearSolar;

extern NSArray * DiaChi;
+ (NSString*)yearOfVietnames:(int)sYear;
+(BOOL)isLeapLunarYear:(int)lYear;
+ (int)getLeapMonthOffset:(int)a11 timeZone:(int)timeZone;

@end

NS_ASSUME_NONNULL_END
