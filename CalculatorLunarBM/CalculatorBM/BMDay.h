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
+ (NSString*)dayOfVietnamese:(NSInteger)day :(NSInteger)month :(NSInteger)year;
- (BMDay *)initWithSDay:(NSInteger)sDay;
- (BMDay *)initWithSDay:(NSInteger)sDay andLDay:(NSInteger)lDay;

@end

NS_ASSUME_NONNULL_END
