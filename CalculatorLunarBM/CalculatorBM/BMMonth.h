//
//  BMMonth.h
//  CalculatorBM
//
//  Created by vincent on 2/7/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMMonth : NSObject
@property (assign) NSUInteger lunarMonth;
@property (assign) NSUInteger solarMonth;
// các hàm khởi tạo
- (BMMonth *)initWithSMonth:(NSInteger)sMonth;
- (BMMonth *)initWithSMonth:(NSInteger)sMonth andLMonth:(NSInteger)lMonth;
- (instancetype)initWithSolarDay:(NSInteger)solarDay solarMonth:(NSInteger)solarMonth solarYear:(NSInteger)solarYear timeZone:(NSInteger)timeZone;
- (instancetype)initWithLunarDay:(NSInteger)lunarDay lunarMonth:(NSInteger)lunarMonth solarYear:(NSInteger)lunarYear isLeapMonth:(BOOL)isLeapMonth timeZone:(NSInteger)timeZone;
@end

NS_ASSUME_NONNULL_END
