//
//  BMPageViewController.h
//  CalculatorBM
//
//  Created by vincent on 2/25/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDate.h"
NS_ASSUME_NONNULL_BEGIN
@protocol BMPageViewControllerDelegate
- (void)pageViewCurrentDate:(BMDate *)currentDate;
@end
@protocol BMPageViewControllerDataSource <NSObject>

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController;

@end


@interface BMPageViewController : UIPageViewController
- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray <UIViewController *> *)controllers;
@property (nonatomic, weak) id <BMPageViewControllerDelegate> BMPaingdelegate;

@end

NS_ASSUME_NONNULL_END
