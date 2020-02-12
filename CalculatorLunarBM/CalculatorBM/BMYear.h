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

- (NSString*)namCanChi;
+ (BOOL)isLeapLunarYear:(NSInteger)lYear;
+ (NSInteger)getLeapMonth:(NSInteger)sYear;
- (BMYear *)initWithSYear:(NSInteger)sMonth;
- (BMYear *)initWithSYear:(NSInteger)sMonth andLYear:(NSInteger)lMonth;

@end

NS_ASSUME_NONNULL_END
