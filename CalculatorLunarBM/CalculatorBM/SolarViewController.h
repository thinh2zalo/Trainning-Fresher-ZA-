//
//  SolarViewController.h
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
#import "DateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SolarViewController : UIViewController
- (DateModel *)getDataModel;
@end

NS_ASSUME_NONNULL_END
