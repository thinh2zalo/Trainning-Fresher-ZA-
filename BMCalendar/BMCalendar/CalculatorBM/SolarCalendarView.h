//
//  SolarCalenDarView.h
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
#import "DateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SolarCalendarView : UIView
- (void)loadDateWithInput:(DateModel *)dataModel;

@end

NS_ASSUME_NONNULL_END
