//
//  BMPageViewController.m
//  CalculatorBM
//
//  Created by vincent on 2/25/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMPageViewController.h"
#import "SolarViewController.h"
@interface BMPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray <UIViewController *>* controllers;
@property (nonatomic, strong) BMDate * currentDate;


@end

@implementation BMPageViewController

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray <UIViewController *> *)controllers {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        self.controllers = controllers;
        self.view.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *firstViewController = self.controllers.firstObject;
    if (firstViewController == NULL) {
        return;
    }
    [self setViewControllers:@[firstViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.dataSource = self;
    self.delegate = self;
}


// delegate

-  (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && finished) {
           [self.BMPaingdelegate pageViewCurrentDate:self.currentDate];
              [self.BMPaingdelegate pageViewCurrentDate:self.currentDate];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    SolarViewController * solarController = (SolarViewController *)pendingViewControllers.lastObject;
//        self.currentDate = solarController.getDate;
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    
    NSInteger index = [self.controllers indexOfObject:viewController];
    SolarViewController * solarController = (SolarViewController *)viewController;
    if (index == NSNotFound || !solarController) {
        return nil;
    }
    NSInteger nextIndex = index + 1;
    
    if (nextIndex == self.controllers.count) {
        [];
//        NSInteger currentJDN = [solarController getJDN];
//           [(SolarViewController *)self.controllers.firstObject setJdn:currentJDN + 1];
        return self.controllers.firstObject;
    }
//    NSInteger currentJDN = [solarController getJDN];
//    [(SolarViewController *)self.controllers[nextIndex] setJdn:currentJDN + 1];
    return self.controllers[nextIndex];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    SolarViewController * solarController = (SolarViewController *)viewController;
    NSInteger index = [self.controllers indexOfObject:viewController];
       if (index == NSNotFound || !solarController) {
           return nil;
       }
        if (index == 0) {
//           NSInteger currentJDN = solarController.getJDN;
//           [(SolarViewController *)self.controllers.lastObject setJdn:currentJDN -1];
           return self.controllers.lastObject;
       }
//        NSInteger previousInDex = index - 1;
//        NSInteger currentJDN = [(SolarViewController *)viewController getJDN];
//
//        [(SolarViewController *)self.controllers[previousInDex] setJdn:currentJDN - 1];
//       return self.controllers[previousInDex];
}


- (NSArray<UIViewController *> *)controllers {
    if (!_controllers) {
        _controllers = NSArray.new;
    }
    return _controllers;
}
@end
