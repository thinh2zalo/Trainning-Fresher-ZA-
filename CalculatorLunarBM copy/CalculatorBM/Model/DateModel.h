//
//  DateModel.h
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
#import <SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface DateModel : NSObject
@property (assign) NSInteger  jdn;
@property (nonatomic, strong) NSString * quote;
@property (nonatomic, strong) NSURL * imageURL;
- (instancetype)initWithDate:(NSInteger)jdn quote:(NSString *)quote imageURL:(NSURL *)imageURL;
+ (DateModel *)createDataModel:(NSInteger)jdn;
@end

NS_ASSUME_NONNULL_END
