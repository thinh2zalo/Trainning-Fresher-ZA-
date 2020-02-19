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
@property (assign) NSUInteger lunarYear;
@property (assign) NSUInteger solarYear;


- (BMYear *)initWithSYear:(NSInteger)sMonth;
- (BMYear *)initWithSYear:(NSInteger)sMonth andLYear:(NSInteger)lMonth;
- (instancetype)initWithSolarDay:(NSInteger)solarDay solarMonth:(NSInteger)solarMonth solarYear:(NSInteger)solarYear timeZone:(NSInteger)timeZone;
- (instancetype)initWithLunarDay:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth solarYear:(NSInteger)lunarYear isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone;


- (NSString*)namCanChi;
+ (NSInteger)getLeapLunarMonth:(NSInteger)lYear;

+ (BOOL)isLeapSolarYear:(NSInteger)solarYear;
+ (BOOL)isLeapLunarYear:(NSInteger)lYear;


- (NSInteger)getLeapLunarMonth;
-(BOOL)isLeapSolarYear;
-(BOOL)isLeapLunarYear;
@end

NS_ASSUME_NONNULL_END
