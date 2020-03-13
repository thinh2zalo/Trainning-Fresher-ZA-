//
//  Quotations.h
//  CalculatorBM
//
//  Created by vincent on 3/2/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingletonAPI : NSObject
+ (SingletonAPI *)sharedInstance;
- (NSArray *)getQuotationArr;
- (NSArray *)getImageArr;
- (NSString *)getQuote:(NSInteger)jdn;
- (NSURL *)getURLImage:(NSInteger)jdn;
@end

NS_ASSUME_NONNULL_END
