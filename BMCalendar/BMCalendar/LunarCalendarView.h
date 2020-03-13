//
//  LunarView.h
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
NS_ASSUME_NONNULL_BEGIN

@interface LunarCalendarView : UIView
- (void)loadDateWithInput:(BMDate *)date;
@end

NS_ASSUME_NONNULL_END
