//
//  SolarMonthYearView.h
//  CalculatorBM
//
//  Created by vincent on 3/3/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMButtonLabel : UIView
-(void)setLabelText:(NSString *)text;
- (void)loadDateWithInput:(BMDate *)date;
@end

NS_ASSUME_NONNULL_END
