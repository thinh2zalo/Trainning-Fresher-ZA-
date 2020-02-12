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
+ (NSString*)monthOfVietnames:(NSInteger)lMonth andYear:(NSInteger)lYear;
- (BMMonth *)initWithSMonth:(NSInteger)sMonth;
- (BMMonth *)initWithSMonth:(NSInteger)sMonth andLMonth:(NSInteger)lMonth;

@end

NS_ASSUME_NONNULL_END
