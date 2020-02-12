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
@property (assign) NSUInteger lunarDay;
@property (assign) NSUInteger solarDay;
+ (NSString*)dayOfVietnamese:(int)day :(int)month :(int)year;
- (BMDay *)initWithSDay:(int)sDay;
- (BMDay *)initWithSDay:(int)sDay andLDay:(int)lDay;

@end

NS_ASSUME_NONNULL_END
