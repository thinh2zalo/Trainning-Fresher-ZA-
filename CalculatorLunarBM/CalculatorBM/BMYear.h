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

+ (NSString*)yearOfVietnames:(int)sYear;
+ (BOOL)isLeapLunarYear:(int)lYear;
+ (int)getLeapMonth:(int)sYear;
- (BMYear *)initWithSYear:(int)sMonth;
- (BMYear *)initWithSYear:(int)sMonth andLYear:(int)lMonth;

@end

NS_ASSUME_NONNULL_END
