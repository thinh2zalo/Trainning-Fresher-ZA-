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
@class BMPageViewController;
@protocol BMPageViewControllerDelegate <NSObject>
- (void)bmPageViewController:(BMPageViewController *)bmPageViewController
willScrollToPageAt:(NSInteger)index direction:(NavigationDirection)direction animated:(BOOL)animated;
- (void)bmPageViewController:(BMPageViewController *)bmPageViewController
didScrollTo:(NSInteger)index;
@end

@protocol BMPageViewControllerDataSource <NSObject>
@required
- (NSInteger)numberOfViewControllers:(BMPageViewController *)bmPageViewController;
- (UIViewController *)viewControllerFor:(BMPageViewController*)bmPageViewController atIndex:(NSInteger)index;
- (NSInteger)defaultPage;
@end
// pageViewController lớp wrap lại UIPageViewController. Với các viewController được lặp lại vô tận.
@interface BMPageViewController : UIPageViewController
@property (nonatomic, weak) id <BMPageViewControllerDelegate> BMPaingDelegate;
@property (nonatomic, weak) id <BMPageViewControllerDataSource> BMPaingDataSource;
- (NSInteger )getCurrentIndex;
@end

NS_ASSUME_NONNULL_END
