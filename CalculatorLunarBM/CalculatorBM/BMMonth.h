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
@property (assign) NSUInteger monthLunar;
@property (assign) NSUInteger monthSolar;
+ (NSString*)monthOfVietnames:(int)lMonth andYear:(int)lYear;

@end

NS_ASSUME_NONNULL_END
