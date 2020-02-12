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
+ (NSString*)monthOfVietnames:(int)lMonth andYear:(int)lYear;
- (BMMonth *)initWithSMonth:(int)sMonth;
- (BMMonth *)initWithSMonth:(int)sMonth andLMonth:(int)lMonth;

@end

NS_ASSUME_NONNULL_END
