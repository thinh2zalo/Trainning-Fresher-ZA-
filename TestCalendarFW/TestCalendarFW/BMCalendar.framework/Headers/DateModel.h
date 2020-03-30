//
//  DateModel.h
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
NS_ASSUME_NONNULL_BEGIN

@interface DateModel : NSObject
@property (assign) NSInteger  jdn;
@property (nonatomic, strong) NSString * quote;
- (instancetype)initWithDate:(NSInteger)jdn quote:(NSString *)quote;
+ (DateModel *)createDataModel:(NSInteger)jdn;
@end

NS_ASSUME_NONNULL_END
